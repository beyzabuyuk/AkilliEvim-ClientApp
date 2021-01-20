import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dictionary.dart';
import '../starting.dart';

class AlarmCard extends StatefulWidget {
  final String title;
  final String image;
  final Operation operation;
  final Device device;

  AlarmCard({
    this.title,
    this.image,
    this.device,
    this.operation,
  });

  @override
  _AlarmCardState createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  @override
  Widget build(BuildContext context) {
    String status = Dictionary.map[widget.device] == false ? "Kapalı" : "Açık";
    Color _color = Colors.white;
    Color _colorText = Colors.black87;
    setState(() {});
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 240,
        width: 240,
        decoration: BoxDecoration(
          color: Dictionary.map[widget.device] == false
              ? _color
              : Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 120,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: Dictionary.map[widget.device] == false
                          ? _color
                          : Theme.of(context).backgroundColor,
                    ),
                  ),
                  CupertinoSwitch(
                    trackColor: Colors.grey[100],
                    activeColor: Colors.grey[400],
                    value: Dictionary.map[widget.device],
                    onChanged: (value) {
                      setState(() {
                        Dictionary.map[widget.device] = value;
                        Uint8List packet = Uint8List.fromList([
                          widget.operation.index,
                          widget.device.index,
                          Dictionary.map[widget.device] == true ? 1 : 0
                        ]);
                        ConnectSocket.send(String.fromCharCodes(packet));
                        print("Giden veri: $packet");
                        if (Dictionary.map[widget.device] == true) {
                          status = 'Açık';
                          _color = Theme.of(context).backgroundColor;
                          _colorText = Colors.white;
                        } else {
                          status = 'Kapalı';
                          _color = Colors.white;
                          _colorText = Colors.black87;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                widget.image,
                width: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
