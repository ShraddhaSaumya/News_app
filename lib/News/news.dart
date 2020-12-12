import 'dart:convert';
import 'package:api_app/Main/drawer.dart';
import 'package:api_app/News/readnews.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

String url, head;

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

int len = 0;

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apiRes;
    String u;
    Future<List<dynamic>> getApi(String url) async {
      u = url;
      var response = await http
          .get(u, headers: {"X-Api-Key": "d0a6829cf6a64fda8651bf2e8052fc11"});
      var _json = json.decode(response.body);
      apiRes = _json["articles"];
      len = apiRes.length;
      return apiRes;
    }

    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.blue[700],
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Ionicons.cash)),
            Tab(icon: Icon(Ionicons.newspaper_sharp)),
            Tab(icon: Icon(Ionicons.book_outline)),
            Tab(icon: Icon(Ionicons.phone_portrait)),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              var temp = await getApi(u);
              setState(() {
                len = temp.length;
              });
              Fluttertoast.showToast(
                  msg: "Refreshed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.blue[200],
                  textColor: Colors.white,
                  fontSize: 12.0);
            },
          ),
          SizedBox(width: 15),
        ],
        title: Text("News Feed"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[800],
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          FutureBuilder(
              future: getApi("http://newsapi.org/v2/everything?q=bitcoin"),
              builder: (context, snapshot) {
                return _apiWidget(snapshot);
              }),
          FutureBuilder(
              future: getApi("http://newsapi.org/v2/top-headlines?country=in&category=business"),
              builder: (context, snapshot) {
                return _apiWidget(snapshot);
              }),
          FutureBuilder(
              future: getApi("http://newsapi.org/v2/top-headlines?country=us&category=science"),
              builder: (context, snapshot) {
                return _apiWidget(snapshot);
              }),
          FutureBuilder(
              future: getApi("http://newsapi.org/v2/top-headlines?country=in&category=technology"),
              builder: (context, snapshot) {
                return _apiWidget(snapshot);
              }),
        ],
      ),
      drawer: DrawerWid(),
    );
  }
}

Widget _apiWidget(AsyncSnapshot snapshot) {
  if (snapshot.connectionState == ConnectionState.done) {
    var data = snapshot.data;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.blue[800],
          elevation: 11,
          child: ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReadNews(data, index))),
            title: Image(
                height: 120,
                fit: BoxFit.cover,
                image: data[index]["urlToImage"] == null
                    ? AssetImage("assets/Classified.jpg")
                    : NetworkImage(data[index]["urlToImage"])),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 7,
                ),
                Text(
                  data[index]["title"],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                   // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height:7
                ),
                Text(
                  data[index]["description"] == null
                      ? "Tap for more info."
                      : data[index]["description"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height:3
                ),
              ],
            ),
          ),
        );
      },
      itemCount: len,
    );
  } else
    return Center(child: CircularProgressIndicator());
}
