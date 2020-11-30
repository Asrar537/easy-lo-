import 'package:easy_lo/common/pdf_viewer/pdf_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({Key key, @required this.pdf}) : super(key: key);
  final PdfModule pdf;

  static void show(BuildContext context, {PdfModule pdf}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => PdfViewer(
          pdf: pdf,
        ),
      ),
    );
  }

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdf?.pdfName??'PDF'),
        centerTitle: true,
        // actions: [
        // TODO:: only need in admin to add program
        // IconButton(
        //   icon: Icon(Icons.add, color: Colors.white),
        //   onPressed: () => {},
        //   //SetSubjectPage.createSubject(context, database: database),
        // )
        // ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Text('usama');
  }
}
