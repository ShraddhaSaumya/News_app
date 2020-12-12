import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var apidata;
var len = 0;

class ReadNews extends StatefulWidget {
  @override
  _ReadNewsState createState() => _ReadNewsState();

  ReadNews(var data, var ind) {
    apidata = data;
    len = ind;
  }
}

class _ReadNewsState extends State<ReadNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 10,
              child: ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        apidata[len]["title"],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Text("Updated: " +
                          apidata[len]["publishedAt"]
                              .toString()
                              .substring(0, 10) +
                          ", " +
                          apidata[len]["publishedAt"]
                              .toString()
                              .substring(11, 19)),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                        height: 30,
                        indent: 15,
                        endIndent: 15,
                      )
                    ]),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                        height: 200,
                        fit: BoxFit.cover,
                        image: apidata[len]["urlToImage"] == null
                            ? AssetImage("assets/Classified.jpg")
                            : NetworkImage(apidata[len]["urlToImage"])),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                      height: 30,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Text(
                        apidata[len]["description"] == null
                            ? "Go to Read More... "
                            : apidata[len]["description"],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.left),
                    FlatButton(
                      onPressed: () => launch(apidata[len]["url"]),
                      child: Text(
                        "Read More...",
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
