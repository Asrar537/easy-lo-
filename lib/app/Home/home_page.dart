import 'package:easy_lo/app/Home/Program/program_page.dart';
import 'package:easy_lo/app/Home/Tab_bottom/cupertino_hom_scaffold.dart';
import 'package:easy_lo/app/Home/Tab_bottom/tab_item_bottom.dart';
import 'package:easy_lo/app/Home/Tab_top/Gnav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItemsBottom _currentTab = TabItemsBottom.home;

  Map<TabItemsBottom, WidgetBuilder> get widgetBuilder {
    return {
      TabItemsBottom.home : (context) => ProgramPage(),
      TabItemsBottom.entries : (context) => Container(),
      TabItemsBottom.account : (context) => Container(),
    };
  }

  final Map<TabItemsBottom, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemsBottom.home: GlobalKey<NavigatorState>(),
    TabItemsBottom.entries: GlobalKey<NavigatorState>(),
    TabItemsBottom.account: GlobalKey<NavigatorState>(),
  };

  void selectTab(TabItemsBottom tabitem){
    if(tabitem == _currentTab){

    }
    else{
      setState(() {
        _currentTab = tabitem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      selectTab: selectTab,
      widgetBuilder: widgetBuilder,
      navigatorKeys: navigatorKeys,
    );
  }
}
