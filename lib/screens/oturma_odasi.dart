import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_smart_home/modeller/modeller.dart';
import 'package:my_smart_home/modeller/secilen_model.dart';
import 'package:my_smart_home/widgets/klima_slider.dart';
import 'package:my_smart_home/widgets/lamba_card.dart';
import 'package:my_smart_home/widgets/secilen_islem.dart';
import 'package:my_smart_home/widgets/zamanlayici.dart';
import 'package:my_smart_home/widgets/widgets.dart';
import '../starting.dart';

class OturmaOdasi extends StatefulWidget {
  final String title;
  OturmaOdasi({Key key, @required this.title}) : super(key: key);

  @override
  _OturmaOdasiState createState() => _OturmaOdasiState();
}

class _OturmaOdasiState extends State<OturmaOdasi> {
  List<SelectModel> _listSelect = [
    SelectModel(
      icon: 'assets/images/light.png',
      name: 'Işık',
    ),
    SelectModel(
      icon: 'assets/images/heater.png',
      name: 'Sıcaklık',
    ),
  ];

  List<LambaModel> _listLighting = [
    LambaModel(
      name: 'Lamba',
      image: 'assets/images/ceiling_lighting.png',
      operation: Operation.UpdateDevice,
      device: Device.O_Lamba,
    ),
    LambaModel(
      name: 'Pencere',
      image: 'assets/images/pencere.jpg',
      operation: Operation.UpdateDevice,
      device: Device.O_Pencere,
    )
  ];

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listSelect.length,
                itemBuilder: (context, index) {
                  return SecilenIslem(
                    icon: _listSelect[index].icon,
                    name: _listSelect[index].name,
                  );
                },
              ),
            ),
            Container(
              height: _height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listLighting.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, top: 16, bottom: 16),
                    child: LambaCard(
                      title: _listLighting[index].name,
                      image: _listLighting[index].image,
                      operation: _listLighting[index].operation,
                      device: _listLighting[index].device,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: textCate(nameCate: 'Klima'),
            ),
            SizedBox(
              height: 16,
            ),
            Klima(),
            KlimaSlider(),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16),
              child: textCate(nameCate: 'Zamanlayıcı'),
            ),
            SizedBox(
              height: 8,
            ),
            Zamanlayici(),
          ],
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
