import 'package:easy_lo/app/Home/Program/program_page_main.dart';
import 'package:easy_lo/app/Home/Tab_bottom/cupertino_hom_scaffold.dart';
import 'package:easy_lo/app/Home/Tab_bottom/tab_item_bottom.dart';
import 'package:easy_lo/app/Home/Main/Main_Home_page.dart';
import 'package:easy_lo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CupertinoTabController cupertinoTabController =
      CupertinoTabController();
  TabItemsBottom _currentTab = TabItemsBottom.home;

  Map<TabItemsBottom, WidgetBuilder> get widgetBuilder {
    return {
      TabItemsBottom.home: (context) => MainHomePage(
            selectTab: selectTab,
          ),
      TabItemsBottom.library: (context) => MainProgramPage(),
    };
  }

  final Map<TabItemsBottom, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItemsBottom.home: new GlobalKey<NavigatorState>(),
    TabItemsBottom.library: new GlobalKey<NavigatorState>(),
  };

  void selectTab(TabItemsBottom tabitem) {
    if (tabitem == _currentTab) {
      navigatorKeys[tabitem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabitem;
        cupertinoTabController.index = tabitem.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKeys[_currentTab].currentState.maybePop();
      },
      child: CupertinoHomeScaffold(
        cupertinoTabController: cupertinoTabController,
        currentTab: _currentTab,
        selectTab: selectTab,
        widgetBuilder: widgetBuilder,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
