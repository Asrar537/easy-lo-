import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/Book/Entries_Video/entries_video_playlist.dart';
import 'package:easy_lo/app/Home/Tab_top/sliver_page.dart';
import 'package:easy_lo/app/Home/Tab_top/tab_item_top.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'Entries_Notes/entries_notes_page.dart';
import 'Entries_Pdf/entries_pdf_page.dart';
import 'Entries_Syllabus/entries_syllabus_page.dart';
import 'Entries_Video/entries_video_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key key, @required this.storageBuilder, this.search})
      : super(key: key);
  final StorageBuilder storageBuilder;
  final IconButton search;

  static void show(BuildContext context, {ProgramEntriesModule entries}) {
    final StorageBuilder storageBuilder =
        Provider.of<StorageBuilder>(context, listen: false);
    final search = Provider.of<IconButton>(context, listen: false);

    Navigator.of(context, rootNavigator: false).push(
      CupertinoPageRoute(
        builder: (context) => Provider<ProgramEntriesModule>(
          create: (_) => entries,
          child: BookPage(
            storageBuilder: storageBuilder,
            search: search,
          ),
        ),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  TabItemsTop _currentPage = TabItemsTop.video;
  PageController controller = PageController();
  ScrollController scrollController = ScrollController();
  int _index = 0;

  Map<TabItemsTop, WidgetBuilder> get widgetBuilder {
    return {
      TabItemsTop.video: (context) => new EntriesVideoPlaylist(),//new EntriesVideoPage(),
      TabItemsTop.pdf: (context) => new EntriesPDFPage(),
      TabItemsTop.syllabus: (context) => new EntriesSallybusPage(),
      TabItemsTop.notes: (context) => new EntriesNotesPage(),
    };
  }

  GButton _buildGButton(TabItemsTop tabItemsTop) {
    final TabItemTopData itemData = TabItemTopData.allTabs[tabItemsTop];
    return GButton(
      gap: itemData.gap,
      icon: itemData.icon,
      iconColor: Colors.grey,
      iconActiveColor: itemData.color,
      text: itemData?.title ?? 'None',
      textColor: itemData.color,
      //backgroundColor: Colors.transparent,
      backgroundColor: Colors.grey.withOpacity(0.3),
      iconSize: 24,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
    );
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

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<ProgramEntriesModule>(context, listen: false);

    return SafeArea(
      child: SliverPage<TabItemsTop>(
        title: Text(
          entries?.name ?? 'Book',
          style: TextStyle(
            color: Color.fromRGBO(32, 168, 151, 1), //change your color here
          ),
        ),
        search: widget.search,
        currentTab: _currentPage,
        selectTab: selectTab,
        gNav: GNav(
          tabMargin: EdgeInsets.symmetric(horizontal: 5),
          curve: Curves.fastOutSlowIn,
          duration: Duration(microseconds: 900),
          tabs: [
            _buildGButton(TabItemsTop.video),
            _buildGButton(TabItemsTop.pdf),
            _buildGButton(TabItemsTop.syllabus),
            _buildGButton(TabItemsTop.notes),
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
      ),
    );
  }
}
