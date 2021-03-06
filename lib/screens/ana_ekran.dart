import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_smart_home/modeller/alarm_model.dart';
import 'package:my_smart_home/modeller/odalar.dart';
import 'package:my_smart_home/notification_islemleri.dart';
import 'package:my_smart_home/packet.dart';
import 'package:my_smart_home/screens/ekranlar.dart';
import 'package:my_smart_home/widgets/cate_container.dart';
import 'package:my_smart_home/widgets/baslik.dart';
import 'package:my_smart_home/widgets/widgets.dart';

import '../starting.dart';
import 'oturma_odasi.dart';
import 'mutfak.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<RoomsModel> _listRooms = [
    RoomsModel(
      image: 'assets/images/oturma_odasi2.jpg',
      name: 'Oturma Odası',
      temp: '${Packet.homeDegree}',
    ),
    RoomsModel(
      image: 'assets/images/kitchen.jpg',
      name: 'Mutfak',
      temp: '24',
    ),
    RoomsModel(
      image: 'assets/images/yatak_odasi.jpg',
      name: 'Yatak Odası',
      temp: '28',
    ),
  ];

  List<AlarmModel> _listAlarm = [
    AlarmModel(
        image: 'assets/images/hirsiz.png',
        name: 'Hırsız Alarmı',
        operation: Operation.UpdateDevice,
        device: Device.A_Hirsiz),
    AlarmModel(
        image: 'assets/images/yanginalarmi.png',
        name: 'Yangın Alarmı',
        operation: Operation.UpdateDevice,
        device: Device.A_Yangin)
  ];

  @override
  void initState() {
    super.initState();
    NotificationHandler().initializeFCMNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Baslik(),
              SizedBox(
                height: _height * 0.05,
              ),
              Container(
                height: _height * 0.45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _listRooms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CateContainer(
                        image: _listRooms[index].image,
                        name: _listRooms[index].name,
                        temp: _listRooms[index].temp,
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OturmaOdasi(
                                          title: _listRooms[index].name,
                                        )));
                          } else if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mutfak(
                                          title: _listRooms[index].name,
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YatakOdasi(
                                          title: _listRooms[index].name,
                                        )));
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 26,
              ),
              textCate(nameCate: 'Alarmlar'),
              SizedBox(
                height: 16,
              ),
              Container(
                height: _height * 0.5,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _listAlarm.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: AlarmCard(
                          title: _listAlarm[index].name,
                          image: _listAlarm[index].image,
                          operation: _listAlarm[index].operation,
                          device: _listAlarm[index].device,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textCate({nameCate}) {
    return Text(
      nameCate,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
