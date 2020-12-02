import 'package:easy_lo/common/pdf_viewer/pdf_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({Key key, @required this.pdf, @required this.future})
      : super(key: key);
  final PdfModule pdf;
  final Future future;

  static void show(BuildContext context, {PdfModule pdf, Future future}) {
    Navigator.of(context, rootNavigator: false).push(
      CupertinoPageRoute(
        builder: (context) => PdfViewer(
          pdf: pdf,
          future: future,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _pdfUrlGet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdf?.pdfName ?? 'PDF'),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshort) {
        if (snapshort.connectionState == ConnectionState.done) {
          String _url = snapshort.data;
          print(_url);
          return const PDF().fromUrl(
            _url,
            placeholder: (double progress) => Center(child: CircularProgressIndicator(strokeWidth: 7, backgroundColor: Colors.red, value: progress,)),
            errorWidget: (dynamic error) => Center(child: Text(error.toString())),
          );
        }
        if (snapshort.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return Center(
          child: Text('Nothing'),
        );
      },
    );
  }
}

// print('url load');
// return FutureBuilder(
//   future: PDFDocument.fromURL(_url),
//   builder: (context, pdf) {
//     if(pdf.hasData){
//       return PDFViewer(document: pdf.data);
//     }
//     if(pdf.hasError){
//       print('usama');
//       print('Error: '+ pdf.error);
//     }
//     return Center(child: CircularProgressIndicator());
//   },
// );

// //for admin pdf picker
// Future getPdfUpload() async {
//   // var rad = new Random();
//   // String randomName = DateTime.now().toIso8601String();
//   // for(int i=0; i< 20; i++){
//   //   randomName += rad.nextInt(100).toString();
//   // }
//   // File file = await FilePicker.platform.pickFiles(type: FileType.any);
//   // String fileName = '${randomName}.pdf';
//   // savePdf();
// }
