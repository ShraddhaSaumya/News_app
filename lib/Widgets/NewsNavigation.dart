import 'package:api_call/Widgets/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'my_flutter_app_icons.dart';

class NewsNavBar extends StatefulWidget {
  final TabController _tabCon;
  NewsNavBar(this._tabCon);

  @override
  _NewsNavBarState createState() => _NewsNavBarState();
}

class _NewsNavBarState extends State<NewsNavBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: TabBar(
        tabs: [
          Tab(
            icon: Icon(MyFlutterApp.newspaper, size: 22),
          ),
          Tab(
            icon: Icon(MyFlutterApp.local_movies, size: 24),
          ),
          Tab(
            icon: Icon(MyFlutterApp.cricket, size: 24),
          ),
          Tab(
            icon: Icon(MyFlutterApp.mobile, size: 27),
          ),
        ],
        controller: widget._tabCon,
      ),
    );
  }
}
