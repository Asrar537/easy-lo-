import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoEntriesTile extends StatelessWidget {
  const VideoEntriesTile({
    Key key,
    @required this.video,
    @required this.onTap,
  }) : super(key: key);

  final ProgramVideoModule video;
  //final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String _videoId = YoutubePlayer.convertUrlToId(video.vUrl);
    if (_videoId == null) {
      return Container();
    }
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      margin: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
      ),
    );
  }
}
