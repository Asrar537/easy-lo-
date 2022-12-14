import 'dart:ui';

import 'package:meta/meta.dart';

class ProgramEntriesModule {
  ProgramEntriesModule({
    @required this.id,
    @required this.name,
    this.dec,
    this.bookUrl,
  });
  final String id;
  final String name;
  final String dec;
  final String bookUrl;
  Future<String> bookCoverDownladUrl;
  Image image;

  factory ProgramEntriesModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String dec = data['dec'];
    final String bookUrl = data['book_url'];
    return ProgramEntriesModule(
        id: documentId, name: name, dec: dec, bookUrl: bookUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dec': dec,
      'book_url': bookUrl,
    };
  }
}
