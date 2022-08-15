import 'package:easy_lo/app/Home/Tab_bottom/tab_item_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key key,
    this.currentTab,
    this.selectTab,
    this.widgetBuilder,
    this.navigatorKeys,
    this.cupertinoTabController,
  }) : super(key: key);

  final TabItemsBottom currentTab;
  final ValueChanged<TabItemsBottom> selectTab;
  final Map<TabItemsBottom, WidgetBuilder> widgetBuilder;
  final Map<TabItemsBottom, GlobalKey<NavigatorState>> navigatorKeys;
  final CupertinoTabController cupertinoTabController;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        controller: cupertinoTabController,
        tabBar: CupertinoTabBar(
          items: [
            _buildTabItem(TabItemsBottom.home),
            _buildTabItem(TabItemsBottom.library),
          ],
          onTap: (index) => selectTab(TabItemsBottom.values[index]),
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: navigatorKeys[TabItemsBottom.values[index]],
            builder: (context) {
              return widgetBuilder[TabItemsBottom.values[index]](context);
            },
          );
        });
  }

  BottomNavigationBarItem _buildTabItem(TabItemsBottom tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color =
        tabItem == currentTab ? Color.fromRGBO(32, 168, 151, 1) : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
    );
  }
}
