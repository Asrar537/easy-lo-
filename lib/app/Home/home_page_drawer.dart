import 'package:easy_lo/app/Home/DrawerUserProfile/DrawerUserProfile.dart';
import 'package:easy_lo/app/Home/home_page.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<StorageBuilder>(
      create: (_) => StorageWidgetBuilder(),
      child: Scaffold(
        drawer: DrawerUserProfile(),
        body: HomePage(),
      ),
    );
  }
}
