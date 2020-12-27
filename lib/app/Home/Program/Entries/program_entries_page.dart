import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/book_entries_page.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramEntriesPage extends StatefulWidget {
  ProgramEntriesPage({this.database});
  final Database database;

  static void show(BuildContext context, {ProgramModule program, Database database, IconButton search}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) =>
            Provider<ProgramModule>(
              create: (_) => program,
              child: Provider<IconButton>(
                create: (_) => search,
                child: ProgramEntriesPage(
                  database: database,
                ),
              ),
            ),
      ),
    );
  }

  @override
  _ProgramEntriesPageState createState() => _ProgramEntriesPageState();
}

class _ProgramEntriesPageState extends State<ProgramEntriesPage>  with AutomaticKeepAliveClientMixin<ProgramEntriesPage>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final program = Provider.of<ProgramModule>(context, listen: false);
    final search  = Provider.of<IconButton>(context, listen: false);
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
                  title: Text(program?.name ?? 'Programs'),
                  centerTitle: true,
                ),
                centerTitle: false,
                actions: [
                  if(search != null)...{
                    search,
                  },
                ],
              ),
            ];
          },
          body: BookEntriesPage(),
        ),
      ),
    );
  }
}