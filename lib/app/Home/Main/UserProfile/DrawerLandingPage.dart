import 'package:easy_lo/app/Home/Main/UserProfile/DrawerUserProfile.dart';
import 'package:easy_lo/app/Home/Sign_in/SignIn_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String user = null;
    //return StreamBuilder(
    // //stream: ,
    // builder: (context, snapshot) {
    //   if (snapshot.connectionState == ConnectionState.active) {
    //     //GUser user = snapshot.data;
    if (user == null) {
      // SignInDialog().show(context);
      return SignInDialog.create(context);
    }
    return DrawerUserProfile();
    //   //   Provider<GUser>.value(
    //   //   value: user,
    //   //   child: Provider<Database>(
    //   //     create: (_) => FireStoreDatabase(uid: user.uid),
    //   //     child: HomePage(),
    //   //   ),
    //   // );
    // } else {
    //   return Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    // },
    // );
  }
}
