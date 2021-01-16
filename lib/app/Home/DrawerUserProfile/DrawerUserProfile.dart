import 'package:easy_lo/app/Home/DrawerUserProfile/About.dart';
import 'package:easy_lo/common/Platform_widget/platform_alert_dialog.dart';
import 'package:easy_lo/common/image/avatar.dart';
import 'package:easy_lo/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerUserProfile extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print('from home page' + e.toString());
    }
  }

  Future<void> _confirmedSignOut(BuildContext context) async {
    //CUP_PlatformAlertDialog
    final logOutRequest = await PlatformAlertDialog(
      title: 'LogOut',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Log-Out',
      cancleActionText: 'Cancel',
    ).show(context);

    if (logOutRequest) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GUser>(context, listen: false);
    String url = user?.photoUrl ?? '';

    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                    color: Color.fromRGBO(225, 255, 247, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Avatar(
                          photoUrl: url,
                          radius: 50,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          user?.displayName ?? 'Name',
                          style: TextStyle(
                              color: Color.fromRGBO(32, 168, 151, 1),
                              fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              children: [
                if (user.email != null) ...[
                  ListTile(
                    leading: Icon(Icons.alternate_email),
                    title: Text(
                      user?.email ?? 'email.example.com',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 6.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => _confirmedSignOut(context),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  About.show(context);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 20,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
