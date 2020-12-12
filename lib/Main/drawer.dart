import 'dart:io';
import 'package:api_app/News/news.dart';
import 'package:api_app/homelogin.dart';
import 'package:flutter/material.dart';
import '../Pages/ccpage.dart';
import 'package:ionicons/ionicons.dart';

class _List extends StatelessWidget {
  String s;
  Function f;
  Icon l,t;
  _List(this.s,this.f,this.l,this.t);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
       ListTile(
            title: Text(s),
            leading: l,
            onTap: f,
            trailing: t,
          ),
          Divider(
            indent: 15,
            endIndent: 15,
            thickness: 1,
            color: Colors.blue,
          ),
      ]);
  }
}
class DrawerWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Shraddha Saumya"),
            accountEmail: Text("shraddhasaumya@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: Text(
                "SS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.pink,
                  Colors.blue,
                ],
            )),
          ),
          _List("Start Page",()=>Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage())),
                  Icon(Ionicons.home),Icon(Icons.arrow_forward_ios,size:16)),
          _List("News Feed",() => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => News())),
                  Icon(Ionicons.newspaper),Icon(Icons.arrow_forward_ios,size:16)),
           _List("Cryptocurrency",() => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CcPage())),
                  Icon(Icons.monetization_on),Icon(Icons.arrow_forward_ios,size:16)),   
          _List("Exit",() => exit(0),
                  Icon(Ionicons.exit),Icon(Icons.arrow_forward_ios,size:16)),
        ],
      ),
    );
  }
}

