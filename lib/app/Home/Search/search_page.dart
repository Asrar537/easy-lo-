import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/Book/Entries_Video/video_player.dart';
import 'package:easy_lo/app/Home/Program/Year/Entries/Book_Entries/Book/book_page.dart';
import 'package:easy_lo/app/Home/Program/Year/Entries/program_entries_page.dart';
import 'package:easy_lo/app/Home/Program/Year/program_page.dart';
import 'package:easy_lo/app/Home/Search/search_list_tile.dart';
import 'package:easy_lo/app/Home/module/program_entry_module.dart';
import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:easy_lo/app/Home/module/program_pdf_module.dart';
import 'package:easy_lo/app/Home/module/program_video_module.dart';
import 'package:easy_lo/common/pdf_viewer/pdf_viewer.dart';
import 'package:easy_lo/services/StorageBuilder.dart';
import 'package:easy_lo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  List<ProgramModule> itemsMainProgram = List();
  List<ProgramModule> itemsProgram = List();
  List<ProgramEntriesModule> itemsBook = List();
  List<ProgramVideoModule> itemsVideo = List();
  List<ProgramPDFModule> itemsPdf = List();
  List<ProgramPDFModule> itemsNotes = List();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {});
  }

  void _submit() async {
    String value = _searchTextController.text;
    if (value.isEmpty) {
      return;
    }
    final database = Provider.of<Database>(context, listen: false);
    try {
      itemsProgram.clear();
      itemsBook.clear();
      itemsVideo.clear();
      itemsPdf.clear();
      final List<Stream<List<dynamic>>> searchResult =
          database.search(queryValue: value);
      searchResult[0].listen((event) {
        itemsMainProgram = event;
      });
      searchResult[1].listen((event) {
        itemsProgram = event;
      });
      searchResult[2].listen((event) {
        itemsBook = event;
      });
      searchResult[3].listen((event) {
        itemsVideo = event;
      });
      searchResult[4].listen((event) {
        itemsPdf = event;
      });
      searchResult[5].listen((event) {
        itemsNotes = event;
      });
      setState(() {});
    } catch (e) {}
  }

  Widget _searchBar() {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 12),
      controller: _searchTextController,
      focusNode: _searchFocusNode,
      placeholder: "Search",
      style: const TextStyle(
        fontSize: 18.0,
        fontFamily: "SanFrancisco",
      ),
      prefix: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(CupertinoIcons.search,
              color: Color.fromRGBO(32, 168, 151, 1))),
      clearButtonMode: OverlayVisibilityMode.editing,
      onChanged: (value) {
        _submit();
      },
      onSubmitted: (value) => _submit(),
      onEditingComplete: _submit,
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black26,
          width: 1.0,
        ),
      ),
    );
  }

  final TextStyle styleHeading = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  final TextStyle styleSearch = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  Widget _searchResult() {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.0),
              color: Colors.white.withOpacity(0.3),
            ),
            child: Column(
              children: (itemsMainProgram.length < 1 &&
                      itemsProgram.length < 1 &&
                      itemsBook.length < 1 &&
                      itemsVideo.length < 1 &&
                      itemsPdf.length < 1 &&
                      itemsNotes.length < 1)
                  ? [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0),
                          child: Text(
                            'No Search Result',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(32, 168, 151, 1)),
                          ),
                        ),
                      ),
                    ]
                  : [
                      if (itemsMainProgram.length > 0) ...[
                        _itemMainProgramList(),
                        Divider(
                          height: 1.0,
                          color: Colors.black26,
                        ),
                      ],
                      if (itemsProgram.length > 0) ...[
                        _itemProgramList(),
                        Divider(
                          height: 1.0,
                          color: Colors.black26,
                        ),
                      ],
                      if (itemsBook.length > 0) ...[
                        _itemBookList(),
                        Divider(
                          height: 1.0,
                          color: Colors.black26,
                        ),
                      ],
                      if (itemsVideo.length > 0) ...[
                        _itemVideoList(),
                        Divider(
                          height: 1.0,
                          color: Colors.black26,
                        ),
                      ],
                      if (itemsPdf.length > 0) ...[
                        _itemPdfList(),
                        Divider(
                          height: 1.0,
                          color: Colors.black26,
                        ),
                      ],
                      if (itemsNotes.length > 0) ...[
                        _itemNotesList(),
                      ],
                    ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemMainProgramList() {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: itemsMainProgram.length,
        itemBuilder: (context, index) {
          return SearchListTile(
            program: itemsMainProgram[index],
            type: Icon(Icons.list),
            onTap: () => ProgramPage.show(context, itemsMainProgram[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1.0,
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget _itemProgramList() {
    final database = Provider.of<Database>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: itemsProgram.length,
        itemBuilder: (context, index) {
          return SearchListTile(
            program: itemsProgram[index],
            type: Icon(
              Icons.list,
              color: Colors.grey[700],
            ),
            onTap: () => ProgramEntriesPage.show(context,
                program: itemsProgram[index], database: database),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1.0,
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget _itemBookList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //primary: false,
      itemCount: itemsBook.length,
      itemBuilder: (context, index) {
        return SearchListTile(
          program: itemsBook[index],
          type: Icon(
            Icons.book,
            color: Colors.grey[700],
          ),
          onTap: () => BookPage.show(context, entries: itemsBook[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1.0,
        color: Colors.black26,
      ),
    );
  }

  Widget _itemVideoList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //primary: false,
      itemCount: itemsVideo.length,
      itemBuilder: (context, index) {
        return SearchListTile(
          program: itemsVideo[index],
          type: Icon(
            Icons.video_collection_rounded,
            color: Colors.grey[700],
          ),
          onTap: () => VideoPlayerScreen.show(context, itemsVideo[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1.0,
      ),
    );
  }

  Widget _itemPdfList() {
    final storageBuilder = Provider.of<StorageBuilder>(context, listen: false);
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemsPdf.length,
      itemBuilder: (context, index) {
        return SearchListTile(
          program: itemsPdf[index],
          type: Icon(
            Icons.menu_book,
            color: Colors.grey[700],
          ),
          onTap: () => PdfViewer.show(context,
              pdf: itemsPdf[index],
              future: storageBuilder.getPdf(context, itemsPdf[index]?.pdfUrl)),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1.0,
      ),
    );
  }

  Widget _itemNotesList() {
    final storageBuilder = Provider.of<StorageBuilder>(context, listen: false);
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemsNotes.length,
      separatorBuilder: (context, index) => Divider(
        height: 0.6,
      ),
      itemBuilder: (context, index) {
        return SearchListTile(
          program: itemsNotes[index],
          type: Icon(
            Icons.note,
            color: Colors.grey[700],
          ),
          onTap: () => PdfViewer.show(context,
              pdf: itemsPdf[index],
              future: storageBuilder.getPdf(context, itemsPdf[index]?.pdfUrl)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _searchBar(),
          _searchResult(),
        ],
      ),
    );
  }
}
