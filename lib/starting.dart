import 'dart:io';
import 'package:my_smart_home/packet.dart';

enum Device {
  O_Lamba,
  O_Pencere,
  O_Klima,
  Y_Lamba,
  Y_Pencere,
  M_Lamba,
  M_Kettle,
  A_Hirsiz,
  A_Yangin,
  S_Termometre
}

enum Operation { Login, UpdateDevice, UpdateValue, LoginResult, Alert }

class ConnectSocket {
  static Socket sock;

  // static void init() async {
  //   sock = await Socket.connect('192.168.0.103', 80);
  // }

  //Alınan datalar durum belirtip ona gore programda aktiflestirilcek.
  static void getData() {
    ConnectSocket.sock.listen((data) {
      Packet packet = new Packet(data);
      packet.handle();
    });
  }

  static void send(String msg) {
    sock.write(msg);
  }
}
