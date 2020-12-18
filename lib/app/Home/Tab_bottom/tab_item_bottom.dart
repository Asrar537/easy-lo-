import 'package:flutter/material.dart';

enum TabItemsBottom{
  home,
  library,
}

class TabItemData{
  TabItemData({@required this.icon, @required  this.title});

  final IconData icon;
  final String title;

  static Map<TabItemsBottom, TabItemData> allTabs = {
    TabItemsBottom.home: TabItemData(icon: Icons.home, title: 'Home'),
    TabItemsBottom.library: TabItemData(icon: Icons.local_library, title: 'Library'),
  };
}