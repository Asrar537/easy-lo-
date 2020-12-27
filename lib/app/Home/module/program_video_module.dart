import 'package:meta/meta.dart';

class ProgramVideoModule {
  ProgramVideoModule({
    @required this.id,
    @required this.name,
    this.dec,
    this.vUrl,
    this.vCata,
  });
  final String id;
  final String name;
  final String dec;
  final String vUrl;
  final int vCata;

  factory ProgramVideoModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String dec = data['dec'];
    final String vUrl = data['VUrl'];
    final int vCata = data['VCata'];
    return ProgramVideoModule(
      id: documentId,
      name: name,
      dec: dec,
      vUrl: vUrl,
      vCata: vCata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dec': dec,
      'VUrl': vUrl,
      'VCata': vCata,
    };
  }
}
