import 'package:flutter/material.dart';

class ImageStructure extends StatelessWidget {
  const ImageStructure({
    this.future,
    this.uloadMsg,
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
          return snapshortBookCover.data;
          //   Image(
          //   image: snapshortBookCover.data,
          // );

        if (snapshortBookCover.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return Center(
          child: Text(uloadMsg??''),
        );
      },
    );
  }
}
