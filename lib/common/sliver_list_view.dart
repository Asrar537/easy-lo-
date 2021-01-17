import 'package:easy_lo/common/list_item/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef ItemWidgetBuilder_onTap<T> = Widget Function(
    BuildContext context, T item);

class SliverListItemBuilder<T> extends StatelessWidget {
  const SliverListItemBuilder({
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
        return SliverToBoxAdapter(child: EmptyContent());
      }
    }
    if (snapshot.hasError) {
      return SliverToBoxAdapter(
        child: EmptyContent(
          title: 'Something went wrong',
          massage: 'Can\'t load items right now',
        ),
      );
    }
    return SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildList(List<T> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            title: itemBuilder(context, items[index]),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
