import 'package:meta/meta.dart';

class ArticalModule {
  ArticalModule({
    @required this.id,
    @required this.dec,
    @required this.name,
    this.url,
  });
  final String id;
  final String name;
  final String dec;
  final String url;

  factory ArticalModule.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String dec = data['dec'];
    final String url = data['url'];
    return ArticalModule(id: documentId, name: name, dec: dec, url: url);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dec': dec,
      'url': url,
    };
  }
}
