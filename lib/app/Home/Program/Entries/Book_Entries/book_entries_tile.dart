import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:flutter/material.dart';

class BookEntriesTile extends StatelessWidget {
  const BookEntriesTile({
    Key key,
    @required this.entries,
    @required this.image,
    @required this.onTap,
  }) : super(key: key);

  final ProgramEntriesModule entries;
  final Widget image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: image,
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
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              //on pressed
                              onTap: onTap,
                              child: Container(
                                margin: EdgeInsets.only(right: 20.0),
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                    ),
                                    color: Colors.yellow,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 12,
                                          offset: Offset(0, 6))
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Read It',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}
