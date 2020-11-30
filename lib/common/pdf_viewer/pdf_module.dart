class PdfModule {
  PdfModule({
    this.pdfName,
    this.pdfUrl,
  });
  final String pdfName;
  final String pdfUrl;

  factory PdfModule.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String pdfName = data['pdfName'];
    final String pdfUrl = data['pdf'];
    return PdfModule(pdfName: pdfName, pdfUrl: pdfUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'pdfName': pdfName,
      'pdf': pdfUrl
    };
  }
}
