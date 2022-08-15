import 'package:easy_lo/app/Home/Main/bodyContent/Artical/Artical.dart';
import 'package:easy_lo/app/Home/Search/set_search_page.dart';
import 'package:easy_lo/app/Home/Tab_bottom/tab_item_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatelessWidget {
  final ValueChanged<TabItemsBottom> selectTab;

  const MainHomePage({Key key, this.selectTab}) : super(key: key);
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
        backgroundColor: Color.fromRGBO(248, 255, 253, 1),
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
          title: Text('Home',
              style: TextStyle(
                color: Color.fromRGBO(32, 168, 151, 1),
              )),
          centerTitle: true,
          actions: [
            search,
          ],
        ),
        body: Artical(
          selectTab: selectTab,
        ),
      ),
    );
  }
}
