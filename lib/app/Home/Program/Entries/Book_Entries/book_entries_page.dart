import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/book_entries_tile.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/common/image/image.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookEntriesPage extends StatelessWidget {
  const BookEntriesPage({Key key, this.program, this.storageBuilder})
      : super(key: key);
  final ProgramModule program;
  final StorageBuilder storageBuilder;

  // static void show(BuildContext context,
  //     {ProgramModule program, Database database}) {
  //   Navigator.of(context).push(
  //     CupertinoPageRoute(
  //       builder: (context) => BookEntriesPage(
  //         database: database,
  //         program: program,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Container(
      child: StreamBuilder<List<ProgramEntriesModule>>(
        stream: database.entriesStream(program: program),
        builder: (context, snapshot) {
          return ListItemBuilder(
            snapshot: snapshot,
            itemBuilder: (context, entries) {
              return BookEntriesTile(
                entries: entries,
                image: ImageStructure(uloadMsg: 'Book',future: storageBuilder.getImage(context, entries?.bookUrl)),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
