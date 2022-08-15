import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/common/sliver_list_view.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_player.dart';

class EntriesVideoPage extends StatelessWidget {
  final String playlistID;

  const EntriesVideoPage({Key key, this.playlistID}) : super(key: key);
  static void show(BuildContext context, String playlistID) {
    Navigator.of(context, rootNavigator: false).push(
      CupertinoPageRoute(
        builder: (context) => EntriesVideoPage(playlistID: playlistID),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 255, 253, 1),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(32, 168, 151, 1),
        ),
        title: Text('Lectures',
            style: TextStyle(
              color: Color.fromRGBO(32, 168, 151, 1),
            )),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<List<ProgramVideoModule>>(
          stream: database.videoStream(playlistId: playlistID ?? 'null'),
          builder: (context, snapshot) {
            return ListItemBuilder<ProgramVideoModule>(
              snapshot: snapshot,
              itemBuilder: (context, video) {
                String _videoId = YoutubePlayer.convertUrlToId(video.vUrl);
                if (_videoId == null) {
                  return Container();
                }
                return Container(
                  child: InkWell(
                    onTap: () async {
                      VideoPlayerScreen.show(context, video);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://i.ytimg.com/vi/$_videoId/hqdefault.jpg',
                              width: 120,
                              height: 100,
                              placeholder: (context, plac) =>
                                  Icon(Icons.image_search),
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
      ),
    );
  }
}
