import 'package:http/http.dart' as http;

class BildirimGondermeServis {
  Future<bool> bildirimGonder(
      String bildirimBaslik, String bildirimNotu, String token) async {
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAFxhRwhs:APA91bGoi_6jJXW4_jA1zh6XoZiEYDnD28M458IiAOwno0Iy_kIYnJomfFH38mTWhhi5f8Ogbo0KKnZB5cXyUE5PDqgSv69L-80R3t5uhex7av7kcLrcvkYoTUDXlQ2sN_9UhciF_bWx";
    //firebaseKey'i firebase'den almak gerekli.
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    String json =
        '{"to" : "$token","data" : {"message" : "$bildirimBaslik", "title" : "$bildirimNotu"}}';

    http.Response response =
        await http.post(endURL, headers: header, body: json);

    if (response.statusCode == 200) {
      print("işlem başarılı");
    } else {
      print("işlem başarısız");
    }
  }
}
