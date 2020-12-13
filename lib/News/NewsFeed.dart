import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import 'NewsReader.dart';
import '../Widgets/NewsNavigation.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

int len = 0;
int abcd;
var apiResp;

class _NewsFeedState extends State<NewsFeed>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<List<dynamic>> getAPI(String query) async {
    String url = query;
    var response = await http
        .get(url, headers: {"X-Api-Key": "71c611e785614e729ba71eb08ec461a3"});
    var _myJson = json.decode(response.body);
    apiResp = _myJson["articles"];
    len = apiResp.length;
    return apiResp;
  }

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            bottomNavigationBar: NewsNavBar(_tabController),
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {});
                    })
              ],
              title: Text('News Feed'),
              centerTitle: true,
            ),
            drawer: DrawerWid(),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                FutureBuilder(
                  future: getAPI(
                      "http://newsapi.org/v2/top-headlines?country=in&category=business&pageSize=40"),
                  builder: (context, snapshot) {
                    return _listBuilder(snapshot);
                  },
                ),
                FutureBuilder(
                  future: getAPI(
                      "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&pageSize=40"),
                  builder: (context, snapshot) {
                    return _listBuilder(snapshot);
                  },
                ),
                FutureBuilder(
                  future: getAPI(
                      "http://newsapi.org/v2/top-headlines?country=in&category=sports&pageSize=40"),
                  builder: (context, snapshot) {
                    return _listBuilder(snapshot);
                  },
                ),
                FutureBuilder(
                  future: getAPI(
                      "http://newsapi.org/v2/top-headlines?country=in&category=technology&pageSize=40"),
                  builder: (context, snapshot) {
                    return _listBuilder(snapshot);
                  },
                ),
              ],
            )));
  }

  Widget _listBuilder(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      var data = snapshot.data;
      return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            borderOnForeground: true,
            child: buildListTile(data, index, context),
          );
        },
        itemCount: len,
      );
    } else {
      print(snapshot.connectionState);
      return Center(child: CircularProgressIndicator());
    }
  }
}

ListTile buildListTile(var data, int index, var context) {
  return ListTile(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewsReader(data[index])));
    },
    title: Image(
      height: 120,
      fit: BoxFit.cover,
      image: data[index]["urlToImage"] == null
          ? AssetImage("assets/newsimg.png")
          : NetworkImage(data[index]["urlToImage"]),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          data[index]["title"] == null
              ? "Tap for more info"
              : data[index]["title"],
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          data[index]["description"] == null
              ? "Tap for more info"
              : data[index]["description"],
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
