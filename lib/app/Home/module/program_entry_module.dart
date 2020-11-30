import 'package:meta/meta.dart';

class ProgramEntriesModule {
  // TODO::id only need in admin
  // TODO::id many not be need
  ProgramEntriesModule(
      {@required this.id,
      @required this.name,
      this.pdfName,
      this.pdfUrl,
      this.dec,
      this.bookUrl});
  final String id;
  final String name;
  final String pdfName;
  final String pdfUrl;
  final String dec;
  final String bookUrl;

  factory ProgramEntriesModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String dec = data['dec'];
    final String pdfName = data['pdfName'];
    final String pdfUrl = data['pdf'];
    final String bookUrl = data['book_url'];
    return ProgramEntriesModule(id: documentId, name: name, pdfName: pdfName ,pdfUrl: pdfUrl, dec: dec, bookUrl: bookUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dec': dec,
      'pdfName': pdfName,
      'pdf': pdfUrl,
      'book_url': bookUrl,
    };
  }
}
