import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({this.video});
  final ProgramVideoModule video;

  static void show(BuildContext context, ProgramVideoModule video) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) => VideoPlayerScreen(
          video: video,
        ),
      ),
    );
  }

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController _controller;
  bool _fullScreen;
  @override
  void initState() {
    super.initState();
    _fullScreen = false;
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video?.vUrl ?? ''),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {}

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            body: _youtubePlayer(),
          );
        } else {
          return Scaffold(
            appBar: _fullScreen
                ? null
                : AppBar(
                    iconTheme: IconThemeData(
                      color: Color.fromRGBO(
                          32, 168, 151, 1), //change your color here
                    ),
                    title: Text(
                      widget.video.name ?? 'video title',
                      style: TextStyle(
                        color: Color.fromRGBO(32, 168, 151, 1),
                      ),
                    ),
                  ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: _youtubePlayer(),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Detail',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.video.dec ?? '...',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget _youtubePlayer() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {},
    );
  }
}

// YoutubePlayer(
// controller: _controller,
// showVideoProgressIndicator: true,
// progressIndicatorColor: Colors.amber,
// progressColors: ProgressBarColors(
// playedColor: Colors.amber,
// handleColor: Colors.amberAccent,
// ),
// )

// return Container(
//   width: MediaQuery.of(context).size.width,
//   height: MediaQuery.of(context).size.height,
//   child: Container(
//     child: WebView(
//       initialUrl: "https://www.youtube.com/embed/80pRyn7fZRk?feature=oembed",
//       javascriptMode: JavascriptMode.unrestricted,
//     ),
//   ),
// );
