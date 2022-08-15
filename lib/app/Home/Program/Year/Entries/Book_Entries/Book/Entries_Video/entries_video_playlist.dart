import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/Book/Entries_Video/entries_video_page.dart';
import 'package:easy_lo/app/Home/Program/Year/program_list_tile.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_pdf_module.dart';
import 'package:easy_lo/app/Home/module/program_video_playlist_module.dart';
import 'package:easy_lo/common/pdf_viewer/pdf_viewer.dart';
import 'package:easy_lo/common/sliver_list_view.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesVideoPlaylist extends StatelessWidget {
  const EntriesVideoPlaylist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final entries = Provider.of<ProgramEntriesModule>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return StreamBuilder<List<ProgramVideoPlaylistModule>>(
      stream: database.videoPlaylistStream(bookId: entries.id),
      builder: (context, snapshot) {
        return SliverListItemBuilder<ProgramVideoPlaylistModule>(
          snapshot: snapshot,
          itemBuilder: (context, playlist) {
            //TODO:: disable in admin page
            return ProgramListTile(
              program: playlist,
              onTap: () => EntriesVideoPage.show(context, playlist.id),
            );
          },
        );
      },
    );
  }
}
