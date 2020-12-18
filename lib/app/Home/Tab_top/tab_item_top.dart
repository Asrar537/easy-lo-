import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItemsTop {
  video,
  pdf,
  syllabus,
  notes,
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
    TabItemsTop.video: TabItemTopData(icon: Icons.ondemand_video_outlined, title: 'Video', color: Colors.orangeAccent),
    TabItemsTop.pdf: TabItemTopData(icon: Icons.picture_as_pdf, title: 'PDF', color: Colors.yellow),
    TabItemsTop.syllabus: TabItemTopData(icon: Icons.list, title: 'Syllabus', color: Colors.deepOrangeAccent),
    TabItemsTop.notes: TabItemTopData(icon: Icons.note, title: 'Notes', color: Colors.brown),
  };
}
