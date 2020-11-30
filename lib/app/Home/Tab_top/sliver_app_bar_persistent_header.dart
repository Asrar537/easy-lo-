import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate{
  SliverAppBarDelegate(this._content);
  final PreferredSize _content;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _content,
    );
  }

  @override
  double get maxExtent => _content.preferredSize.height;

  @override
  double get minExtent => _content.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}