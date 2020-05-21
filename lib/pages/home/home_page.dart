import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/home/cupertino_home_scaffold.dart';
import 'package:timetrackerapp/pages/home/entries/entries_page.dart';
import 'package:timetrackerapp/pages/home/profile/profile_page.dart';
import 'package:timetrackerapp/pages/home/tab_item.dart';

import 'jobs/jobs_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  void _select(TabItem tabItem){
    setState(() {
      if(tabItem==_currentTab)
        navigatorKey[tabItem].currentState.popUntil((route) => route.isFirst);
      else
        _currentTab = tabItem;
    });
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey={
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries : (context) => EntriesPage.create(context),
      TabItem.profile: (_) => ProfilePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKey[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
