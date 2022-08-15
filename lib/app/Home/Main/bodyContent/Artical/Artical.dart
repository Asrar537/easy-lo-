import 'package:easy_lo/app/Home/Main/bodyContent/Artical/Artical_tile.dart';
import 'package:easy_lo/app/Home/Main/bodyContent/main_body_content.dart';
import 'package:easy_lo/app/Home/Tab_bottom/tab_item_bottom.dart';
import 'package:easy_lo/app/Home/module/artical_module.dart';
import 'package:easy_lo/common/list_item/empty_content.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Artical extends StatelessWidget {
  final ValueChanged<TabItemsBottom> selectTab;

  const Artical({Key key, this.selectTab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Container(
      child: StreamBuilder<List<ArticalModule>>(
        stream: database.articalStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ArticalModule> items = snapshot.data;
            if (items.isNotEmpty) {
              return _buildList(items);
            } else {
              return EmptyContent();
            }
          }
          if (snapshot.hasError) {
            return EmptyContent(
              title: 'Something went wrong',
              massage: 'Can\'t load items right now',
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(List items) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              MainBodyContent(
                selectTab: selectTab,
              ),
              ArticalTile(
                artical: items[index],
              ),
            ],
          );
        } else {
          return ArticalTile(
            artical: items[index],
          );
        }
      },
    );
  }
}
