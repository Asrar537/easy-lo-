import 'package:flutter/material.dart';

enum TabItemsBottom{
  home,
  library,
}

class TabItemData{
  TabItemData({@required this.icon});

  final IconData icon;

  static Map<TabItemsBottom, TabItemData> allTabs = {
    TabItemsBottom.home: TabItemData(icon: Icons.home),
    TabItemsBottom.library: TabItemData(icon: Icons.local_library),
  };
}