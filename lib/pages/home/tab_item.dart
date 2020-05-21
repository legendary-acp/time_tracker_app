import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { jobs, entries, profile }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.jobs: TabItemData(title: 'Jobs', icon: Icons.work),
    TabItem.entries: TabItemData(title: 'Entries', icon: Icons.border_color),
    TabItem.profile: TabItemData(title: 'Profile', icon: Icons.person),
  };
}