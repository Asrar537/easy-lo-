import 'package:meta/meta.dart';

class ProgramSallybusModule {
  ProgramSallybusModule({@required this.id, @required this.head,@required this.detail,});
  final String id;
  final String head;
  final List<String> detail;

  factory ProgramSallybusModule.fromMap(Map<String, dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String head = data['head'];
    final List<String> detail = List();
    data['detail'].forEach((element) {
      detail.add(element);
    });

    return ProgramSallybusModule(id: documentId, head: head, detail: detail);
  }

  Map<String, dynamic> toMap() {
    return {
      'head': head,
      'detail' : detail
    };
  }
}
