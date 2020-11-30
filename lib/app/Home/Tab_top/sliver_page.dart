import 'package:easy_lo/app/Home/Tab_top/sliver_app_bar_persistent_header.dart';
import 'package:easy_lo/app/Home/Tab_top/tab_item_top.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SliverPage extends StatelessWidget {
  SliverPage({
    this.title,
    this.gNav,
    this.currentTab,
    this.selectTab,
    this.widgetBuilder,
    this.scrollController,
    this.controller,
  });

  final Text title;
  final GNav gNav;
  final TabItemsTop currentTab;
  final ValueChanged<int> selectTab;
  final Map<TabItemsTop, WidgetBuilder> widgetBuilder;
  final PageController controller;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 150.0,
                elevation: 0,
                floating: true,
                snap: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  title: title,
                  centerTitle: true,
                ),
                centerTitle: false,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  PreferredSize(
                    preferredSize: Size.fromHeight(52),
                    child: Container(
                      margin: EdgeInsets.zero,
                      decoration:
                          BoxDecoration(color: Colors.indigo, boxShadow: [
                        BoxShadow(
                          spreadRadius: -10,
                          blurRadius: 30,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 25),
                        )
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          child: gNav,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: PageView.builder(
            itemCount: TabItemsTop.values.length,
            controller: controller,
            onPageChanged: (index) {
              if(index > 3) {
                scrollController.jumpTo((index-3) * 60.0);
              }
              return selectTab(index);
            },
            itemBuilder: (context, postion) {
              return widgetBuilder[TabItemsTop.values[postion]](context);
            },
          ),
        ),
      ),
    );
  }
}
