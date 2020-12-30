import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_smart_home/dictionary.dart';
import '../starting.dart';

class LightingCard extends StatefulWidget {
  final String title;
  final String image;
  final Operation operation;
  final Device device;

  LightingCard({this.title, this.image, this.operation, this.device});
  @override
  _LightingCardState createState() => _LightingCardState();
}

class _LightingCardState extends State<LightingCard> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    String status = Dictionary.map[widget.device] == false ? "Kapalı" : "Açık";
    Color _color = Colors.white;
    Color _colorText = Colors.black87;

    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Container(
        height: _height * 0.3,
        width: _width * 0.7,
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
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //Lamba
                    widget.title,
                    style: TextStyle(
                      color: Dictionary.map[widget.device] == false
                          ? _colorText
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    //Açık kapalı durumu
                    status,
                    style: TextStyle(
                        color: Dictionary.map[widget.device] == false
                            ? _colorText
                            : Colors.white),
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
                        print("$packet");

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
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
