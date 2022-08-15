import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_sallybus_module.dart';
import 'package:easy_lo/common/sliver_list_view.dart';
import 'package:easy_lo/common/tabel_from_map.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesSallybusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final entries = Provider.of<ProgramEntriesModule>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return StreamBuilder<List<ProgramSallybusModule>>(
      stream: database.syllabusStream(bookId: entries.id),
      builder: (context, snapshot) {
        return SliverListItemBuilder<ProgramSallybusModule>(
          snapshot: snapshot,
          itemBuilder: (context, sallybus) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(title: TabelFromData(data: sallybus)),
            );
          },
        );
      },
    );
  }
}
