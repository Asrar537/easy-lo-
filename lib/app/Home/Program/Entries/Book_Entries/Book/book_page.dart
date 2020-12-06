import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/Book/Entries_Pdf/entries_pdf_page.dart';
import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/Book/Entries_Video/entries_video_page.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key key, @required this.storageBuilder})
      : super(key: key);
  final StorageBuilder storageBuilder;


  static void show(BuildContext context, {ProgramEntriesModule entries, StorageBuilder storageBuilder}) {
    Navigator.of(context, rootNavigator: false).push(
      CupertinoPageRoute(
        builder: (context) => Provider<ProgramEntriesModule>(
          create: (_) => entries,
          child: BookPage(
            storageBuilder: storageBuilder,
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage>{

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<ProgramEntriesModule>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(entries?.name??'Book'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.ondemand_video),
                text: 'Video',
              ),
              Tab(
                icon: Icon(Icons.picture_as_pdf),
                text: 'PDF',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EntriesVideoPage(storageBuilder: widget.storageBuilder, database: database, entries: entries),
            EntriesPDFPage(storageBuilder: widget.storageBuilder),
          ],
        ),
      ),
    );
  }
}

//builder(_,isLoading,_) => child: EntriesVideoPage(storageBuilder: widget.storageBuilder, database: database, entries: entries),

