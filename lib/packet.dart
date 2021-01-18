import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_smart_home/dictionary.dart';
import 'package:my_smart_home/main.dart';
import 'package:my_smart_home/starting.dart';
import 'package:my_smart_home/widgets/alarm_card.dart';

class Packet {
  Uint8List packet;
  int index;

  Packet(Uint8List pkt) {
    packet = pkt;
    index = 0;
  }

  int getByte() {
    return packet.elementAt(index++);
  }

  bool getBool() {
    return getByte() == 1;
  }

  Device getDevice() {
    return Device.values[getByte()];
  }

  Operation getOperation() {
    return Operation.values[getByte()];
  }

  bool handle() {
    Operation operation = getOperation();

    switch (operation) {
      case Operation.UpdateValue:
        return OnUpdateValue();
      case Operation.LoginResult:
        return OnLoginResult();
      case Operation.Alert:
        return OnAlert();
      default:
        break;
    }
    return false;
  }

  bool OnAlert() {
    switch (getDevice()) {
      case Device.A_Hirsiz:
        print("Hırsız vaaaaaar!!");
        return true;
      case Device.A_Yangin:
        print("Yangın vaaaar!!");
        return true;
      default:
    }
    return false;
  }

  bool OnLoginResult() {
    Dictionary.map[Device.O_Lamba] = getBool();
    Dictionary.map[Device.O_Pencere] = getBool();
    Dictionary.map[Device.O_Klima] = getBool();
    Dictionary.map[Device.Y_Lamba] = getBool();
    Dictionary.map[Device.Y_Pencere] = getBool();
    Dictionary.map[Device.M_Lamba] = getBool();
    Dictionary.map[Device.M_Kettle] = getBool();
    Dictionary.map[Device.A_Hirsiz] = getBool();
    Dictionary.map[Device.A_Yangin] = getBool();
    return true;
  }

  static int homeDegree;
  bool OnUpdateValue() {
    //Termometre
    switch (getDevice()) {
      case Device.S_Termometre:
        homeDegree = getByte();
        print("Klima derecesi: " + homeDegree.toString()); //Termometre derecesi
        return true;
      default:
    }
    return false;
  }
}
