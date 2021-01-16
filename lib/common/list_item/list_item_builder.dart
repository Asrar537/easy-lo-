import 'package:easy_lo/common/list_item/empty_content.dart';
import 'package:flutter/material.dart';

typedef ItemWidgetBuilder_onTap<T> = Widget Function(
    BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder_onTap<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
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
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        height: 0.6,
      ),
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
