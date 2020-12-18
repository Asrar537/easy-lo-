import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:flutter/material.dart';

class BookEntriesTile extends StatelessWidget {
  const BookEntriesTile({
    Key key,
    @required this.entries,
    //@required this.image,
    @required this.onTap,
  }) : super(key: key);

  final ProgramEntriesModule entries;
  //final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 6))
                      ]),
                ),
                Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.0, top: 18.0, bottom: 18.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 6))
                          ]),
                      child: Container(
                        height: 164,
                        width: 110,
                        child: CachedNetworkImage(
                          imageUrl: entries.bookUrl,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      )
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 18.0, right: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              entries?.name ?? 'Book',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              entries?.dec ?? '',
                              style:
                                  TextStyle(color: Colors.black38, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
