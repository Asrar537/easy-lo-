import 'package:easy_lo/app/Home/Main/UserProfile/DrawerLandingPage.dart';
import 'package:easy_lo/app/landing_page.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:easy_lo/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
              child: Provider<Database>(
                create: (_) => FireStoreDatabase(),
                child: LandingPage(),
              ),
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
