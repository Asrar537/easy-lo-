import 'package:easy_lo/app/Home/Tab_top/sliver_app_bar_persistent_header.dart';
import 'package:easy_lo/app/Home/Tab_top/tab_item_top.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SliverPage<T> extends StatelessWidget {
  SliverPage({
    this.title,
    this.gNav,
    this.currentTab,
    this.selectTab,
    this.widgetBuilder,
    this.scrollController,
    this.controller,
    this.search,
  });

  final Text title;
  final GNav gNav;
  final T currentTab;
  final ValueChanged<int> selectTab;
  final Map<T, WidgetBuilder> widgetBuilder;
  final PageController controller;
  final ScrollController scrollController;
  final Widget search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: NestedScrollView(
          headerSliverBuilder: (_, __) => [],
          body: Builder(
            builder: (BuildContext context) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context2, bool innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        iconTheme: IconThemeData(
                          color: Color.fromRGBO(
                              32, 168, 151, 1), //change your color here
                        ),
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
                        actions: [
                          if (search != null) ...{
                            search,
                          },
                        ],
                      ),
                    ),
                    if (gNav != null) ...{
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context2),
                        sliver: SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverAppBarDelegate(
                            PreferredSize(
                              preferredSize: Size.fromHeight(52),
                              child: Container(
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(225, 255, 247, 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      scrollDirection: Axis.horizontal,
                                      child: Center(child: gNav),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    },
                  ];
                },
                body: SafeArea(
                  top: false,
                  bottom: false,
                  child: PageView.builder(
                    itemCount: TabItemsTop.values.length,
                    controller: controller,
                    onPageChanged: (index) {
                      if (index > 3) {
                        scrollController.jumpTo((index - 3) * 60.0);
                      }
                      return selectTab(index);
                    },
                    itemBuilder: (context, postion) {
                      return Builder(
                        builder: (context2) {
                          return CustomScrollView(
                            slivers: [
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                              ),
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context2),
                              ),
                              SliverPadding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                sliver:
                                    widgetBuilder[TabItemsTop.values[postion]](
                                        context),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
