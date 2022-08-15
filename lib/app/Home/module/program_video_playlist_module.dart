import 'package:meta/meta.dart';

class ProgramVideoPlaylistModule {
  ProgramVideoPlaylistModule({
    @required this.id,
    @required this.name,
  });
  final String id;
  final String name;
  factory ProgramVideoPlaylistModule.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    return ProgramVideoPlaylistModule(
      id: documentId,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
