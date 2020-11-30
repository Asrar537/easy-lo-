import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

enum TabItemsTop {
  book,
  video,
  syllabus,
  notes,
  info,
}

class TabItemTopData {
  TabItemTopData({
    @required this.icon,
    @required this.title,
    this.color = Colors.black54,
    this.colorInActive = Colors.white,
    this.gap = 10.0,
  });

  final IconData icon;
  final String title;
  final Color color;
  final Color colorInActive;
  final double gap;

  static Map<TabItemsTop, TabItemTopData> allTabs = {
    TabItemsTop.book: TabItemTopData(icon: Icons.book, title: 'Book', color: Colors.yellow),
    TabItemsTop.video: TabItemTopData(icon: Icons.ondemand_video_outlined, title: 'Video', color: Colors.orangeAccent),
    TabItemsTop.syllabus: TabItemTopData(icon: Icons.list, title: 'Syllabus', color: Colors.deepOrangeAccent),
    TabItemsTop.notes: TabItemTopData(icon: Icons.note, title: 'Notes', color: Colors.brown),
    TabItemsTop.info: TabItemTopData(icon: Icons.info, title: 'Info', color: Colors.red),

  };
}
