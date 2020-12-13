import 'package:api_call/Stock/crypto.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import '../News/NewsFeed.dart';

class DrawerWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          currentAccountPicture: CircleAvatar(
              minRadius: 29.6,
              backgroundColor: Colors.black12,
              child: CircleAvatar(
                backgroundColor: Colors.amber.shade500,
                maxRadius: 29.5,
                child: Text(
                  'Y',
                  style: TextStyle(fontSize: 36),
                ),
              )),
          accountName: Text('Yash',
              style: TextStyle(
                fontSize: 18,
              )),
          accountEmail: Text("Yash6334@gmail.com"),
        ),
        _MyListTile(
            "News Feed",
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewsFeed())),
            Icon(Icons.library_books)),
        _MyListTile(
            "Stock Market",
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CryptoPage())),
            Icon(Icons.monetization_on)),
        _MyListTile("Close", () => exit(0), Icon(Icons.close)),
      ],
    ));
  }
}

class _MyListTile extends StatelessWidget {
  final String title;
  final Function f;
  final Icon _icon;

  _MyListTile(this.title, this.f, this._icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          title: Text(title,
              style: TextStyle(
                fontSize: 15,
              )),
          onTap: f,
          leading: _icon,
          trailing: Icon(Icons.arrow_right),
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
