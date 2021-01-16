import 'package:easy_lo/app/Home/Program/Year/Entries/program_entries_page.dart';
import 'package:easy_lo/app/Home/Program/Year/program_list_tile.dart';
import 'package:easy_lo/app/Home/Search/set_search_page.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({Key key, this.cataId}) : super(key: key);

  final ProgramModule cataId;

  static void show(BuildContext context, ProgramModule mainProgram) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ProgramPage(
          cataId: mainProgram,
        ),
      ),
    );
  }

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
        iconTheme: IconThemeData(
          color: Color.fromRGBO(32, 168, 151, 1), //change your color here
        ),
        elevation: 0,
        title: Text(
          cataId?.name ?? 'Programs',
          style: TextStyle(
            color: Color.fromRGBO(32, 168, 151, 1),
          ),
        ),
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
    return Container(
      margin: EdgeInsets.all(12),
      child: StreamBuilder<List<ProgramModule>>(
        stream: database.programStream(mainProgramId: cataId.id),
        builder: (context, snapshot) {
          return ListItemBuilder(
            snapshot: snapshot,
            itemBuilder: (context, program) {
              return ProgramListTile(
                program: program,
                onTap: () => ProgramEntriesPage.show(context,
                    program: program, database: database, search: search),
              );
            },
          );
        },
      ),
    );
  }
}
