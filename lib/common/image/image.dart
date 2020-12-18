import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageStructure extends StatelessWidget {
  const ImageStructure({
    this.future,
    this.uloadMsg = 'Nothing',
  });
  final Future future;
  final String uloadMsg;

  @override
  Widget build(BuildContext context) {
    if(future == null){
      return Center(
        child: Text(uloadMsg??''),
      );
    }
    return FutureBuilder(
      future: future,
      builder: (context, snapshortBookCover) {
        if (snapshortBookCover.connectionState == ConnectionState.done)
          return CachedNetworkImage(
            imageUrl: snapshortBookCover.data,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        if (snapshortBookCover.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return Center(
          child: Text(uloadMsg),
        );
      },
    );
  }
}
