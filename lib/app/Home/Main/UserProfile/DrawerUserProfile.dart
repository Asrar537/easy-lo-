import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url = '';
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
                        //bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(colors: [
                        Colors.indigo,
                        Colors.indigoAccent,
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.camera_alt_outlined),
                          backgroundImage: url.isEmpty
                              ? null
                              : CachedNetworkImageProvider(url),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'usama naeem',
                          style: TextStyle(color: Colors.white, fontSize: 25),
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
                ListTile(
                  leading: Icon(Icons.alternate_email),
                  title: Text(
                    'email.example.com',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
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
                  onPressed: () => {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
