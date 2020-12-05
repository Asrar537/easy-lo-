import 'package:easy_lo/app/Home/Program/Entries/program_entries_page.dart';
import 'package:easy_lo/app/Home/Program/program_list_tile.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
        centerTitle: true,
        actions: [
          //TODO:: only need in admin to add program
          // IconButton(
          //   icon: Icon(Icons.add, color: Colors.white),
          //   onPressed: () => {},
          //   //SetSubjectPage.createSubject(context, database: database),
          // )
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<ProgramModule>>(
      stream: database.programStream(),
      builder: (context, snapshot) {
        return ListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, program) {
            //TODO:: disable in admin page
            return ProgramListTile(
              leading: const FlutterLogo(),
              program: program,
              onTap: () => ProgramEntriesPage.show(context, program: program, database: database),
            );
          },
        );
      },
    );
  }
}
