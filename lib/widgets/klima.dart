import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_smart_home/models/klima_model.dart';

import 'package:my_smart_home/starting.dart';

import '../dictionary.dart';
import '../starting.dart';

class Klima extends StatefulWidget {
  final Operation operation = Operation.UpdateDevice;
  final Device device = Device.O_Klima;
  int degreeUpdate;
  @override
  _KlimaState createState() => _KlimaState();
}

class _KlimaState extends State<Klima> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Color _color = Colors.white;
    // ignore: unused_local_variable
    Color _colorText = Colors.black87;
    String status = Dictionary.map[widget.device] == false ? "Kapalı" : "Açık";
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(color: _colorText),
          ),
          CupertinoSwitch(
            trackColor: Colors.grey[100],
            activeColor: Colors.grey[400],
            value: Dictionary.map[widget.device],
            onChanged: (value) {
              setState(() {
                Dictionary.map[widget.device] = value;
                widget.degreeUpdate = KlimaModel.klimamodel();

                if (Dictionary.map[widget.device] == true) {
                  Uint8List packet = Uint8List.fromList([
                    widget.operation.index,
                    widget.device.index,
                    1,
                    widget.degreeUpdate
                  ]);
                  ConnectSocket.send(String.fromCharCodes(packet));
                  print("$packet");
                  status = 'Kapat';
                  _color = Theme.of(context).backgroundColor;
                  _colorText = Colors.white;
                } else {
                  Uint8List packet = Uint8List.fromList(
                      [widget.operation.index, widget.device.index, 0]);
                  ConnectSocket.send(String.fromCharCodes(packet));
                  print("$packet");
                  status = 'Kapat';
                  status = 'Aç';
                  _color = Colors.white;
                  _colorText = Colors.black87;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
