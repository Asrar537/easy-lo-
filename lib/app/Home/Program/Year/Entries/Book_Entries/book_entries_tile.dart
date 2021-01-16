import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:flutter/material.dart';

class BookEntriesTile extends StatelessWidget {
  const BookEntriesTile({
    Key key,
    @required this.entries,
    @required this.onTap,
  }) : super(key: key);

  final ProgramEntriesModule entries;
  //final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
      child: ListTile(
        onTap: onTap,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  //height: 164,
                  imageUrl: entries.bookUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    height: 110,
                    width: 80,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 110,
                    height: 80,
                    child: Center(child: Icon(Icons.error)),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      entries?.name ?? 'Book',
                      style: TextStyle(
                        color: Color.fromRGBO(32, 168, 151, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      entries?.dec ?? '',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
