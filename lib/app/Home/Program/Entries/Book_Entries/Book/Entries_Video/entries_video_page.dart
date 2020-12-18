import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/Book/Entries_Video/video_player.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EntriesVideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final entries = Provider.of<ProgramEntriesModule>(context, listen: false);
    return Container(
      child: StreamBuilder<List<ProgramVideoModule>>(
        stream: database.videoStream(bookId: entries?.id ?? 'null'),
        builder: (context, snapshot) {
          return ListItemBuilder<ProgramVideoModule>(
            snapshot: snapshot,
            itemBuilder: (context, video) {
              String _videoId = YoutubePlayer.convertUrlToId(video.VUrl);
              if(_videoId == null) {
                return Container();
              }
              return Container(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) => VideoPlayerScreen(
                          videoId: video?.VUrl ?? '',
                          videoTitle: video.name,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: CachedNetworkImage(
                            imageUrl: 'https://i.ytimg.com/vi/$_videoId/hqdefault.jpg',
                            width: 120,
                            height: 100,
                            placeholder: (context, plac) => Icon(Icons.image_search),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(child: Text(video.name)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}