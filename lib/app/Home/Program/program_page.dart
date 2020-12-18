import 'package:easy_lo/app/Home/Program/Entries/program_entries_page.dart';
import 'package:easy_lo/app/Home/Program/program_list_tile.dart';
import 'package:easy_lo/app/Home/Search/set_search_page.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final search = IconButton(
      icon: Icon(Icons.search),
      onPressed: () => {
        SetSearchPage.createSearch(context),
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
        centerTitle: true,
        actions: [
          search,
        ],
      ),
      body: _buildContent(context, search),
    );
  }

  Widget _buildContent(BuildContext context, IconButton search) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<ProgramModule>>(
      stream: database.programStream(),
      builder: (context, snapshot) {
        return ListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, program) {
            return ProgramListTile(
              leading: const FlutterLogo(),
              program: program,
              onTap: () => ProgramEntriesPage.show(context,
                  program: program, database: database, search: search),
            );
          },
        );
      },
    );
  }
}
