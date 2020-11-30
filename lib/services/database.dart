import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/services/database_files/api_path.dart';
import 'package:easy_lo/services/firestore_service/firestore_service.dart';

abstract class Database {
  //Future<void> setSubject(Subject subjectData);
  Stream<List<ProgramModule>> programStream();
  // Future<void> deleteSubject(Subject subject);
  // Future<void> setEntries(Entry entry);
  Stream<List<ProgramEntriesModule>> entriesStream({ProgramModule program});
  // Future<void> deleteEntry(Entry entry);
}

class FireStoreDatabase implements Database {
  // FireStoreDatabase({@required this.uid}) : assert(uid != null);
  // final String uid;
  final _firetoreService = FirestoreService.instance;
  //
  // @override
  // Future<void> setSubject(Subject subjectData) async =>
  //     await _firetoreService.setData(
  //       path: APIPath.subject(uid, subjectData.id),
  //       data: subjectData.toMap(),
  //     );
  //
  // @override
  // Future<void> deleteSubject(Subject subject) async =>
  //     await _firetoreService.deleteData(path: APIPath.subject(uid, subject.id));

  @override
  Stream<List<ProgramModule>> programStream() =>
      _firetoreService.readCollection<ProgramModule>(
        path: APIPath.programs(),
        builder: (data, documentId) => ProgramModule.fromMap(data, documentId),
      );

  // //entries
  // @override
  // Future<void> setEntries(Entry entry) async => await _firetoreService.setData(
  //       path: APIPath.subjectEntry(uid, entry.id),
  //       data: entry.toMap(),
  //     );
  //
  @override
  Stream<List<ProgramEntriesModule>> entriesStream({ProgramModule program}) {
    return _firetoreService.readCollection<ProgramEntriesModule>(
      path: APIPath.programEntries(),
      builder: (data, documentId) => ProgramEntriesModule.fromMap(data, documentId),
      queryBuilder: program != null ? (query) => query.where('proId', isEqualTo: program.id,) : null,
    );
  }
  // @override
  // Future<void> deleteEntry(Entry entry) async => await _firetoreService
  //     .deleteData(path: APIPath.subjectEntry(uid, entry.id));
}
