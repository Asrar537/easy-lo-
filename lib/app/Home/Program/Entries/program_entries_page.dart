import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/book_entries_page.dart';
import 'package:easy_lo/app/Home/Tab_top/sliver_page.dart';
import 'package:easy_lo/app/Home/Tab_top/tab_item_top.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class ProgramEntriesPage extends StatefulWidget {
  ProgramEntriesPage({this.database, this.program});
  final Database database;
  final ProgramModule program;
  final StorageBuilder _storageBuilder = StorageWidgetBuilder();

  static void show(BuildContext context,
      {ProgramModule program, Database database}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ProgramEntriesPage(
          database: database,
          program: program,
        ),
      ),
    );
  }

  @override
  _ProgramEntriesPageState createState() => _ProgramEntriesPageState();
}

class _ProgramEntriesPageState extends State<ProgramEntriesPage> {
  TabItemsTop _currentPage = TabItemsTop.book;
  PageController controller = PageController();
  ScrollController scrollController = ScrollController();
  int _index = 0;

  Map<TabItemsTop, WidgetBuilder> get widgetBuilder {
    return {
      TabItemsTop.book: (context) => BookEntriesPage(program: widget.program, storageBuilder: widget._storageBuilder),
      TabItemsTop.video: (context) => Container(),
      TabItemsTop.syllabus: (context) => Container(),
      TabItemsTop.notes: (context) => Container(),
      TabItemsTop.info: (context) => Container(),
    };
  }

  void selectTab(int index) {
    TabItemsTop tabitem = TabItemsTop.values[index];
    if (tabitem == _currentPage) {
    } else {
      setState(() {
        _index = index;
        _currentPage = tabitem;
      });
    }
  }

  GButton _buildGButton(TabItemsTop tabItemsTop) {
    final TabItemTopData itemData = TabItemTopData.allTabs[tabItemsTop];
    return GButton(
      gap: itemData.gap,
      icon: itemData.icon,
      iconColor: Colors.white,
      iconActiveColor: itemData.color,
      text: itemData?.title ?? 'None',
      textColor: itemData.color,
      backgroundColor: Colors.grey.withOpacity(0.3),
      iconSize: 24,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return SliverPage(
      title: Text(widget.program?.name ?? 'Programs'),
      currentTab: _currentPage,
      selectTab: selectTab,
      gNav: GNav(
        curve: Curves.fastOutSlowIn,
        duration: Duration(microseconds: 900),
        tabs: [
          _buildGButton(TabItemsTop.book),
          _buildGButton(TabItemsTop.video),
          _buildGButton(TabItemsTop.syllabus),
          _buildGButton(TabItemsTop.notes),
          _buildGButton(TabItemsTop.info),
        ],
        selectedIndex: _index,
        onTabChange: (index) {
          selectTab(index);
          controller.jumpToPage(index);
        },
      ),
      widgetBuilder: widgetBuilder,
      controller: controller,
      scrollController: scrollController,
    );
  }
}
