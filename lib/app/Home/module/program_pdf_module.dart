import 'package:meta/meta.dart';

class ProgramPDFModule {
  // TODO::id only need in admin
  // TODO::id many not be need
  ProgramPDFModule(
      {@required this.id,
        this.name,
        this.pdfUrl,
        this.pdfCata,
      });
  final String id;
  final String name;
  final String pdfUrl;
  final int pdfCata;

  factory ProgramPDFModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['pdfName'];
    final String pdfUrl = data['pdfUrl'];
    final int pdfCata = data['pdfCata'];
    return ProgramPDFModule(id: documentId, name: name ,pdfUrl: pdfUrl, pdfCata: pdfCata);
  }

  Map<String, dynamic> toMap() {
    return {
      'pdfName': name,
      'pdfUrl': pdfUrl,
      'pdfCata': pdfCata,
    };
  }
}
