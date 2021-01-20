import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("Arka planda gelen data:" + message["data"].toString());
    NotificationHandler.showNotification(message);
  }

  return Future<void>.value();
}

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();
  static final NotificationHandler _singleton = NotificationHandler._internal();
//Kurucu metodlarda geriye bir şeyler return etmeye yarar
  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();

  initializeFCMNotification(BuildContext context) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    String token = await _fcm.getToken();
    print("token:" + token);

    _fcm.onTokenRefresh.listen((newToken) async {
      User _currentUser = await FirebaseAuth.instance.currentUser;
      print(_currentUser);
      await FirebaseFirestore.instance
          .doc("/tokens/" + _currentUser.uid)
          .set({"token": token});
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //uygulama açıkken
        print("onMessage tetiklendi: $message");
        showNotification(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        //uygulama tamamen kapalıyken
        print("onLaunch tetiklendi: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        //uygulama background'da
        print("onResume tetiklendi: $message");
      },
    );
  }

  static void showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "1234", "Yeni Bildirim", "channelDescription",
        importance: Importance.max, priority: Priority.high, ticker: "ticker");
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message["data"]["title"],
        message["data"]["message"], platformChannelSpecifics,
        payload: 'Bildirim tıklanılınca aktarılan değer');
  }

  Future onSelectNotification(String payload) {
    //payload: bildirim tıklanıldığında veri yollayabilirsin
    if (payload != null) {
      debugPrint("notification payload:" + payload);
    }
  }

  Future onDidReceiveLocalNotification(
      //ios için
      int id,
      String title,
      String body,
      String payload) {}
}
