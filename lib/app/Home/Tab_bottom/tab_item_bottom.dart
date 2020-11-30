import 'package:flutter/material.dart';

enum TabItemsBottom{
  home,
  entries,
  account,
}

class TabItemData{
  TabItemData({@required this.icon, @required  this.title});

  final IconData icon;
  final String title;

  static Map<TabItemsBottom, TabItemData> allTabs = {
    TabItemsBottom.home: TabItemData(icon: Icons.home, title: 'Home'),
    TabItemsBottom.entries: TabItemData(icon: Icons.view_headline, title: 'Entries'),
    TabItemsBottom.account: TabItemData(icon: Icons.person, title: 'Account'),
  };
}