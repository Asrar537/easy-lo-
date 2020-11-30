import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Stream<List<T>> readCollection<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query reference = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      reference = queryBuilder(reference);
    }
    final Stream<QuerySnapshot> snapshorts = reference.snapshots();
    return snapshorts.map((event) {
      final result = event.docs
          .map((e) {
            return builder(e.data(), e.id);
          }).where((values) => values!=null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
