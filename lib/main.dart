import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_smart_home/screens/ekranlar.dart';
import 'package:my_smart_home/starting.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  ConnectSocket.sock = await Socket.connect('192.168.1.23', 80);
  ConnectSocket.getData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akıllı Evim',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          mainAlbumImage(),
          loginSection(context),
        ],
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

mainAlbumImage() {
  return Container(
    width: double.infinity,
    height: 600,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      image: DecorationImage(
        image: AssetImage("assets/images/giris.png"),
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.0), BlendMode.luminosity),
        fit: BoxFit.cover,
      ),
    ),
    padding: EdgeInsets.only(
      left: 30,
      top: 200,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          'BENIM AKILLI',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white70,
              fontSize: 30.0,
            ),
          ),
        ),
        Text(
          'EVIM',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}

loginSection(BuildContext context) {
  String username = "admin";
  String password = "123456";
  String password1, username1;
  final myUsername = TextEditingController();
  final myPassword = TextEditingController();

  return Container(
    width: double.infinity,
    height: 360,
    decoration: new BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[300],
          blurRadius: 5.0, // soften the shadow
          spreadRadius: 0.0, //extend the shadow
          offset: Offset(
            0, // Move to right 10  horizontally
            10.0, // Move to bottom 10 Vertically
          ),
        )
      ],
    ),
    margin: EdgeInsets.only(
      top: 320,
      left: 25,
      right: 25,
    ),
    padding: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Text(
          'Evine Hosgeldin!',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 15.0,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          'Ev cihazınızı yönetin',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.blueAccent,
              fontSize: 15.0,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        TextField(
          onChanged: (String text) {
            username1 = text;
          },
          decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
          controller: myUsername,
        ),
        SizedBox(height: 5.0),
        TextField(
          onChanged: (String text) {
            password1 = text;
          },
          obscureText: true,
          decoration:
              InputDecoration(labelText: 'Şifre', focusColor: Colors.blue),
          controller: myPassword,
        ),
        SizedBox(height: 25.0),
        RaisedGradientButton(
          child: Text(
            'Giriş Yap',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          gradient: LinearGradient(
            colors: <Color>[Colors.blueAccent, Colors.purple],
          ),
          onPressed: () {
            username == username1 && password == password1
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AnaEkran()))
                : showAlertDialog(context);
            myPassword.clear();
            myUsername.clear();
          },
        ),
        SizedBox(height: 10.0),
      ],
    ),
  );
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("TAMAM"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Hata"),
    content: Text("Kullanıcı adı veya şifre hatalı!"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// ignore: non_constant_identifier_names
