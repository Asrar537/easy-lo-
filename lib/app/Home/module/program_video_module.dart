import 'package:meta/meta.dart';

class ProgramVideoModule {
  // TODO::id only need in admin
  // TODO::id many not be need
  ProgramVideoModule({
    @required this.id,
    @required this.name,
    this.VDec,
    this.VUrl,
    this.VCata,
  });
  final String id;
  final String name;
  final String VDec;
  final String VUrl;
  final int VCata;

  factory ProgramVideoModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['VName'];
    final String VDec = data['VDec'];
    final String VUrl = data['VUrl'];
    final int VCata = data['VCata'];
    return ProgramVideoModule(
      id: documentId,
      name: name,
      VDec: VDec,
      VUrl: VUrl,
      VCata: VCata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'VDec': VDec,
      'VUrl': VUrl,
      'VCata': VCata,
    };
  }
}
