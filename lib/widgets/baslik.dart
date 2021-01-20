import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_smart_home/main.dart';

class Baslik extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
      debugPrint("çıkış yapıldı");
    } else {
      debugPrint("Hiçbir oturum açık değil");
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 24, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Evine Hoşgeldin',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'beyzbykk@gmail.com',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
          Stack(
            overflow: Overflow.visible,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: _width * 0.15,
                  height: _height * 0.07,
                  child: Image.asset(
                    'assets/images/beyza.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 70),
                child: FloatingActionButton(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.exit_to_app),
                    onPressed: () {
                      _cikisYap();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
