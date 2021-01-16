import 'package:easy_lo/app/Home/module/program_pdf_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({Key key, @required this.pdf, @required this.future})
      : super(key: key);
  final ProgramPDFModule pdf;
  final Future future;

  static void show(BuildContext context,
      {ProgramPDFModule pdf, Future future}) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(32, 168, 151, 1), //change your color here
        ),
        title: Text(
          widget.pdf?.name ?? 'PDF',
          style: TextStyle(
            color: Color.fromRGBO(32, 168, 151, 1), //change your color here
          ),
        ),
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
          return const PDF().fromUrl(
            _url,
            placeholder: (double progress) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: progress.toInt(),
                    stepSize: 10,
                    selectedColor: Colors.greenAccent,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 15,
                    roundedCap: (_, __) => true,
                  ),
                  Text('$progress%'),
                ],
              ),
            ),
            errorWidget: (dynamic error) =>
                Center(child: Text(error.toString())),
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
