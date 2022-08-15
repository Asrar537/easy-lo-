import 'package:easy_lo/app/Home/Search/bottom_sheet_widget.dart';
import 'package:easy_lo/app/Home/Search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetSearchPage extends StatelessWidget {
  static Future<void> createSearch(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(25.0),
      //   ),
      // ),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SetSearchPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: CustomBottomSheet(
        buildContent: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: SearchPage(),
        ),
      ),
    );
  }
}
