import 'package:easy_lo/app/landing_page.dart';
import 'package:easy_lo/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy lo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:  buildContentHomePage(context),
    );
  }

  Widget buildContentHomePage(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text(
                  "Error: ${snapshot.error}"
              ),
            ),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done) {
          return Provider<Database>(
            create: (_) => FireStoreDatabase(),
            child: LandingPage(),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}
