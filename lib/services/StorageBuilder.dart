import 'package:easy_lo/services/firestore_service/firebaseStroage.dart';
import 'package:flutter/material.dart';

abstract class StorageBuilder{
  Future<Widget> getImage(BuildContext context, String bookUrl);
  Future<String> getPdf(BuildContext context, String pdfUrl);
}

class StorageWidgetBuilder implements StorageBuilder{
  final _firebaseStorageServices = FirebaseStorageServices.instance;

  @override
  Future<Widget> getImage(BuildContext context, String bookUrl) async {
    Image bookCover;
    await _firebaseStorageServices.loadFromStorage(context, bookUrl).then((value) {
      bookCover = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return bookCover;
  }


  @override
  Future<String> getPdf(BuildContext context, String pdfUrl) async {
    String url;
    await _firebaseStorageServices.loadFromStorage(context, pdfUrl).then((value) {
      url = value.toString();
    });
    return url;
  }
}
