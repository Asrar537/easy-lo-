import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/Book/Entries_Video/video_player.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:easy_lo/services/httpServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesVideoPage extends StatefulWidget {
  const EntriesVideoPage(
      {Key key, this.storageBuilder, this.database, this.entries})
      : super(key: key);
  final StorageBuilder storageBuilder;
  final Database database;
  final ProgramEntriesModule entries;

  @override
  _EntriesVideoPageState createState() => _EntriesVideoPageState();
}

class _EntriesVideoPageState extends State<EntriesVideoPage>{
  ScrollController _scrollController;
  List<ProgramVideoModule> videosLink;
  List<dynamic> videoDetail;
  bool isLoading = true;
  int currentRead = 0;
  @override
  void initState() {
    _scrollController = ScrollController();
    videosLink = List<ProgramVideoModule>();
    videoDetail = List<dynamic>();
    _getVideoLink();
  }

  _getVideoLink() async {
    widget.database.videoStream(bookId: widget.entries?.id ?? 'null').listen((event) async {
      await event.forEach((element) async {
        videosLink.add(element);
      });
      await _getVideoDetail();
      setState(() {
        isLoading = false;
      });
    });
    //await _getVideoDetail();
  }

  Future<void> _getVideoDetail() async {
    print(videosLink.length);
    for (int i = currentRead; i < videosLink.length && i < 20; i++) {
      currentRead++;
      await HttpServices.getDetail(videosLink[i].VUrl)
          .then((value) => videoDetail.add(value));
    }
    print(videoDetail.length);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    final database = Provider.of<Database>(context, listen: false);
    final entries = Provider.of<ProgramEntriesModule>(context, listen: false);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
      child: ListView.builder(
          controller: _scrollController,
          itemCount: videoDetail.length,
          itemBuilder: (context, index) {
            final video = videosLink[index];
            final Vdata = videoDetail[index];
            String title =
            video?.name == "" ? Vdata['title'] : video?.name;
            return Container(
              //padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: InkWell(
                onTap: () async {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => VideoPlayerScreen(
                        videoUrl: video?.VUrl ?? '',
                        videoTitle: title,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: CachedNetworkImage(
                          imageUrl: Vdata['thumbnail_url'],
                          width: 120,
                          height: 100,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(child: Text(title)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
