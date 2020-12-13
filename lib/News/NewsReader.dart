import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

var apiRes;

class NewsReader extends StatefulWidget {
  NewsReader(var data) {
    apiRes = data;
  }

  @override
  _NewsReaderState createState() => _NewsReaderState();
}

class _NewsReaderState extends State<NewsReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 10,
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    apiRes["title"],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Updated: " +
                        apiRes["publishedAt"].toString().substring(0, 10) +
                        ", " +
                        apiRes["publishedAt"].toString().substring(11, 19),
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                  Divider(
                      height: 30,
                      color: Colors.black,
                      indent: 15,
                      endIndent: 15,
                      thickness: 1),
                  Image(
                    image: apiRes["urlToImage"] != null
                        ? NetworkImage(apiRes["urlToImage"])
                        : AssetImage("assets/newsimg.png"),
                    fit: BoxFit.cover,
                  ),
                  Divider(
                      height: 30,
                      color: Colors.black,
                      indent: 15,
                      endIndent: 15,
                      thickness: 1),
                  apiRes["description"] != null
                      ? Text(
                          apiRes["description"],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        )
                      : Text("Tap on Read More"),
                  GestureDetector(
                    onTap: () async {
                      var url = apiRes["url"];
                      await launch(url);
                    },
                    child: Center(
                      child: Text(
                        "Read More",
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
