import 'package:easy_lo/app/Home/module/artical_module.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/app/Home/module/program_pdf_module.dart';
import 'package:easy_lo/app/Home/module/program_sallybus_module.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:easy_lo/services/database_files/api_path.dart';
import 'package:easy_lo/services/firestore_service/firestore_service.dart';

abstract class Database {
  Stream<List<ProgramModule>> mainProgramStream();
  Stream<List<ProgramModule>> programStream({String mainProgramId});
  Stream<List<ProgramEntriesModule>> entriesStream({String programId});
  Stream<List<ProgramPDFModule>> pdfBookStream({String bookId});
  Stream<List<ProgramPDFModule>> pdfNotesStream({String bookId});
  Stream<List<ProgramSallybusModule>> syllabusStream({String bookId});
  Stream<List<ProgramVideoModule>> videoStream({String bookId});
  Stream<List<ArticalModule>> articalStream();

  List<Stream<List<dynamic>>> search({String queryValue});
}

class FireStoreDatabase implements Database {
  final _firetoreService = FirestoreService.instance;

  @override
  Stream<List<ProgramModule>> mainProgramStream() =>
      _firetoreService.readCollection<ProgramModule>(
        path: APIPath.mainPrograms(),
        builder: (data, documentId) => ProgramModule.fromMap(data, documentId),
        sort: (lhs, rhs) => lhs.name.compareTo(rhs.name),
      );

  @override
  Stream<List<ProgramModule>> programStream({String mainProgramId}) =>
      _firetoreService.readCollection<ProgramModule>(
        path: APIPath.programs(),
        builder: (data, documentId) => ProgramModule.fromMap(data, documentId),
        queryBuilder: mainProgramId != null
            ? (query) => query.where('mainProgramId', isEqualTo: mainProgramId)
            : null,
        sort: (lhs, rhs) => lhs.name.compareTo(rhs.name),
      );
  @override
  Stream<List<ProgramEntriesModule>> entriesStream({String programId}) {
    return _firetoreService.readCollection<ProgramEntriesModule>(
      path: APIPath.programEntries(),
      builder: (data, documentId) =>
          ProgramEntriesModule.fromMap(data, documentId),
      queryBuilder: programId != null
          ? (query) => query.where('proId', isEqualTo: programId)
          : null,
    );
  }

  Stream<List<ProgramPDFModule>> _pdfStream({String bookId, String path}) =>
      _firetoreService.readCollection<ProgramPDFModule>(
        path: path,
        builder: (data, documentId) =>
            ProgramPDFModule.fromMap(data, documentId),
        queryBuilder: bookId != null
            ? (query) => query.where(
                  'bookId',
                  isEqualTo: bookId,
                )
            : null,
        sort: (lhs, rhs) => lhs.pdfCata.compareTo(rhs.pdfCata),
      );

  @override
  Stream<List<ProgramPDFModule>> pdfBookStream({String bookId}) =>
      _pdfStream(bookId: bookId, path: APIPath.pdf());

  @override
  Stream<List<ProgramPDFModule>> pdfNotesStream({String bookId, String path}) =>
      _pdfStream(bookId: bookId, path: APIPath.note());

  @override
  Stream<List<ProgramSallybusModule>> syllabusStream({String bookId}) =>
      _firetoreService.readCollection<ProgramSallybusModule>(
        path: APIPath.syllabus(),
        builder: (data, documentId) =>
            ProgramSallybusModule.fromMap(data, documentId),
        queryBuilder: bookId != null
            ? (query) => query.where(
                  'bookId',
                  isEqualTo: bookId,
                )
            : null,
      );

  @override
  Stream<List<ProgramVideoModule>> videoStream({String bookId}) =>
      _firetoreService.readCollection<ProgramVideoModule>(
        path: APIPath.video(),
        builder: (data, documentId) =>
            ProgramVideoModule.fromMap(data, documentId),
        queryBuilder: bookId != null
            ? (query) => query.where(
                  'bookId',
                  isEqualTo: bookId,
                )
            : null,
      );

  Stream<List<ArticalModule>> articalStream() =>
      _firetoreService.readCollection<ArticalModule>(
        path: APIPath.artical(),
        builder: (data, documentId) => ArticalModule.fromMap(data, documentId),
      );

  @override
  List<Stream<List<dynamic>>> search({String queryValue}) {
    final List<Stream<List<dynamic>>> resultList = List();
    resultList.add(_firetoreService.readCollectionForSearch<ProgramModule>(
      path: APIPath.mainPrograms(),
      builder: (data, documentId) => ProgramModule.fromMap(data, documentId),
      queryKey: queryValue.toLowerCase(),
      lookIn: ['name'],
    ));
    resultList.add(_firetoreService.readCollectionForSearch<ProgramModule>(
      path: APIPath.programs(),
      builder: (data, documentId) => ProgramModule.fromMap(data, documentId),
      queryKey: queryValue.toLowerCase(),
      lookIn: ['name'],
    ));
    resultList
        .add(_firetoreService.readCollectionForSearch<ProgramEntriesModule>(
      path: APIPath.programEntries(),
      builder: (data, documentId) =>
          ProgramEntriesModule.fromMap(data, documentId),
      queryKey: queryValue.toLowerCase(),
      lookIn: ['name', 'dec'],
    ));
    resultList.add(_firetoreService.readCollectionForSearch<ProgramVideoModule>(
      path: APIPath.video(),
      builder: (data, documentId) =>
          ProgramVideoModule.fromMap(data, documentId),
      queryKey: queryValue.toLowerCase(),
      lookIn: ['name', 'dec'],
    ));
    resultList.add(_firetoreService.readCollectionForSearch<ProgramPDFModule>(
      path: APIPath.pdf(),
      builder: (data, documentId) => ProgramPDFModule.fromMap(data, documentId),
      queryKey: queryValue.toLowerCase(),
      lookIn: ['name'],
    ));
    resultList.add(_firetoreService.readCollectionForSearch<ProgramPDFModule>(
      path: APIPath.note(),
      builder: (data, documentId) => ProgramPDFModule.fromMap(data, documentId),
      queryKey: queryValue.toLowerCase(),
      lookIn: ['name'],
    ));
    return resultList;
  }
}
