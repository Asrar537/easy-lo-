import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/Program/Entries/Book_Entries/Book/Entries_Video/video_player.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:easy_lo/common/list_item/list_item_builder.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:easy_lo/services/httpServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesVideoPage extends StatefulWidget {
  const EntriesVideoPage({Key key, this.storageBuilder}) : super(key: key);
  final StorageBuilder storageBuilder;

  @override
  _EntriesVideoPageState createState() => _EntriesVideoPageState();
}

class _EntriesVideoPageState extends State<EntriesVideoPage> {
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
              return FutureBuilder(
                future: HttpServices.getDetail(video?.VUrl),
                builder: (context, videotile) {
                  if (videotile.connectionState == ConnectionState.done && videotile.hasData) {
                    final Vdata = videotile.data;
                    String title = video?.name == ""?Vdata['title']:video?.name;
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: CachedNetworkImage(
                                imageUrl: Vdata['thumbnail_url'],
                                width: 120,
                                height: 100,
                              ),
                            ),
                            //SizedBox(width: 20),
                            Flexible(child: Text(title)),
                          ],
                        ),
                      ),
                    );
                  }
                  if (videotile.connectionState == ConnectionState.waiting) {
                    print('in loading');
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: Text('Nothing'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
