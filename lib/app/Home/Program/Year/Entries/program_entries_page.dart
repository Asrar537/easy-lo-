import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/book_entries_page.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramEntriesPage extends StatefulWidget {
  ProgramEntriesPage({this.database});
  final Database database;

  static void show(BuildContext context,
      {ProgramModule program, Database database, IconButton search}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => Provider<ProgramModule>(
          create: (_) => program,
          child: Provider<IconButton>(
            create: (_) => search,
            child: ProgramEntriesPage(
              database: database,
            ),
          ),
        ),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  _ProgramEntriesPageState createState() => _ProgramEntriesPageState();
}

class _ProgramEntriesPageState extends State<ProgramEntriesPage>
    with AutomaticKeepAliveClientMixin<ProgramEntriesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final program = Provider.of<ProgramModule>(context, listen: false);
    final search = Provider.of<IconButton>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                    title: Text(
                      program?.name ?? 'Programs',
                      style: TextStyle(
                        color: Color.fromRGBO(
                            32, 168, 151, 1), //change your color here
                      ),
                    ),
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
            ];
          },
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverToBoxAdapter(
                      child: BookEntriesPage(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
