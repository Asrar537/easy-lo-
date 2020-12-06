import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  //
  VideoPlayerScreen({this.videoTitle, this.videoUrl});
  final String videoUrl;
  final String videoTitle;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController _controller;
  bool _isPlayerReady;
  bool _fullScreen;
  @override
  void initState() {
    super.initState();
    _fullScreen = false;
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    // if (_controller.value.isFullScreen) {
    //   setState(() {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.landscapeRight,
    //       DeviceOrientation.landscapeLeft,
    //     ]);
    //     SystemChrome.setEnabledSystemUIOverlays([]);
    //     _fullScreen = true;
    //   });
    // }
    // else{
    //   setState(() {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.portraitUp,
    //     ]);
    //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //     _fullScreen = false;
    //   });
    // }
  }

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
      builder: (BuildContext context, Orientation orientation){
        if(orientation == Orientation.landscape){
          return Scaffold(
            body: _youtubePlayer(),
          );
        }
        else{
          return Scaffold(
            appBar: _fullScreen ? null: AppBar(
              title: Text('usama'),
            ),
            body: Container(
              child: _youtubePlayer(),
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
      onReady: () {
        _isPlayerReady = true;
      },
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