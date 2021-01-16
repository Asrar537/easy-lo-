import 'package:easy_lo/app/Home/Program/Year/program_list_tile.dart';
import 'package:easy_lo/app/Home/Program/Year/program_page.dart';
import 'package:easy_lo/app/Home/Search/set_search_page.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final search = IconButton(
      icon: Icon(
        Icons.search,
        color: Color.fromRGBO(32, 168, 151, 1),
      ),
      onPressed: () => {
        SetSearchPage.createSearch(context),
      },
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Color.fromRGBO(32, 168, 151, 1),
              ),
              onPressed: () {
                final ScaffoldState scaffoldState =
                    context.findRootAncestorStateOfType<ScaffoldState>();
                scaffoldState.openDrawer();
              },
            ),
          ),
          title: Text(
            'Library',
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
      ),
    );
  }

  Widget _buildContent(BuildContext context, IconButton search) {
    final database = Provider.of<Database>(context, listen: false);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(12),
        child: StreamBuilder<List<ProgramModule>>(
          stream: database.mainProgramStream(),
          builder: (context, snapshot) {
            return ListItemBuilder(
              snapshot: snapshot,
              itemBuilder: (context, program) {
                return ProgramListTile(
                  program: program,
                  onTap: () => ProgramPage.show(context, program),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
