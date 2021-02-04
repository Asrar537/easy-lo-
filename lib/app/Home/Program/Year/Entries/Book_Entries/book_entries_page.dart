import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/Book/book_page.dart';
import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/book_entries_tile.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/common/sliver_list_view.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookEntriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final program = Provider.of<ProgramModule>(context, listen: false);
    return StreamBuilder<List<ProgramEntriesModule>>(
      stream: database.entriesStream(programId: program?.id ?? null),
      builder: (context, snapshot) {
        return SliverListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, entries) {
            return BookEntriesTile(
              entries: entries,
              onTap: () => BookPage.show(context, entries: entries),
            );
          },
        );
      },
    );
  }
}
