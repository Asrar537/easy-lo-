import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseStorageServices extends ChangeNotifier {
  FirebaseStorageServices._();
  static final instance = FirebaseStorageServices._();

  Future<dynamic> loadFromStorage(BuildContext context, String url) async {
    return await FirebaseStorage.instance.ref().child(url).getDownloadURL();
  }
}
