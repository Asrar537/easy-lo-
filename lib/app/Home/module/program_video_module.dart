import 'package:meta/meta.dart';

class ProgramVideoModule {
  ProgramVideoModule({
    @required this.id,
    @required this.name,
    this.dec,
    this.VUrl,
    this.VCata,
  });
  final String id;
  final String name;
  final String dec;
  final String VUrl;
  final int VCata;

  factory ProgramVideoModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String dec = data['dec'];
    final String VUrl = data['VUrl'];
    final int VCata = data['VCata'];
    return ProgramVideoModule(
      id: documentId,
      name: name,
      dec: dec,
      VUrl: VUrl,
      VCata: VCata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dec': dec,
      'VUrl': VUrl,
      'VCata': VCata,
    };
  }
}
