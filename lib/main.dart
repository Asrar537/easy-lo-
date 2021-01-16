import 'package:easy_lo/app/landing_page.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(225, 255, 247, .1),
    100: Color.fromRGBO(225, 255, 247, .2),
    200: Color.fromRGBO(225, 255, 247, .3),
    300: Color.fromRGBO(225, 255, 247, .4),
    400: Color.fromRGBO(225, 255, 247, .5),
    500: Color.fromRGBO(225, 255, 247, .6),
    600: Color.fromRGBO(225, 255, 247, .7),
    700: Color.fromRGBO(225, 255, 247, .8),
    800: Color.fromRGBO(225, 255, 247, .9),
    900: Color.fromRGBO(225, 255, 247, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy lo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFE1FFF7, color),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Provider<AuthBase>(
              create: (context) => Auth(),
              child: LandingPage(),
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
