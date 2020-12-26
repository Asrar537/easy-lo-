import 'package:easy_lo/app/Home/home_page_drawer.dart';
import 'package:easy_lo/app/Sign_in/SignIn_dialog.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GUser user = snapshot.data;
          if (user == null) {
            return SignInDialog.create(context);
          }
          return Provider<GUser>.value(
            value: user,
            child: Provider<Database>(
              create: (_) => FireStoreDatabase(),//uid: user.uid
              child: HomePageDrawer(),
            ),
          );
        } else {
          //when snapshot has no data not even null show app is loading
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
