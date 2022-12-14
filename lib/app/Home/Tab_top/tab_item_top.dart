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
    this.colorInActive = Colors.grey,
    this.gap = 10.0,
  });

  final IconData icon;
  final String title;
  final Color color;
  final Color colorInActive;
  final double gap;

  static Map<TabItemsTop, TabItemTopData> allTabs = {
    TabItemsTop.video: TabItemTopData(icon: Icons.ondemand_video_outlined, title: 'Lectures', color: Color.fromRGBO(32, 168, 151, 1)),
    TabItemsTop.pdf: TabItemTopData(icon: Icons.picture_as_pdf, title: 'PDF', color: Color.fromRGBO(32, 168, 151, 1)),
    TabItemsTop.syllabus: TabItemTopData(icon: Icons.list, title: 'Course', color: Color.fromRGBO(32, 168, 151, 1)),
    TabItemsTop.notes: TabItemTopData(icon: Icons.note, title: 'Past Papers', color: Color.fromRGBO(32, 168, 151, 1)),
  };
}
