import 'package:meta/meta.dart';

class ProgramModule {
  ProgramModule({@required this.id, @required this.name});
  final String id;
  final String name;

  factory ProgramModule.fromMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String name = data['name'];
    return ProgramModule(id: documentId, name: name);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
