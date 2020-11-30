import 'package:meta/meta.dart';

class ProgramModule {
  // TODO::id only need in admin
  ProgramModule({@required this.id, @required this.name});
  final String id;
  final String name;

  factory ProgramModule.fromMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String name = data['course'];
    return ProgramModule(id: documentId, name: name);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
