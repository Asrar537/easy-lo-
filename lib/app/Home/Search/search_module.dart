import 'package:meta/meta.dart';

class SearchModule {
  SearchModule({
    @required this.name,
    this.dec,
    @required this.fromType,
    @required this.lead,
  });

  final String name;
  final String dec;
  final int fromType;
  final String lead;

  factory SearchModule.fromMap(Map<String, dynamic> data, String documentId, int fromType) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String dec = data['dec'];
    String lead = documentId;
    // print('result');
    // print(name);
    // print(dec);
    // print('end');
    return SearchModule(name: name, dec:  dec, fromType: fromType, lead: lead);
  }
}

//
// program id to book
//     book id to pdf and video
//     video url to video screen
//     pdf