import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CryptoPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

int len = 0;

class _MyAppState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    var apiResp;

    Future<List<dynamic>> getAPI() async {
      String url =
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
      var response = await http.get(url, headers: {
        "X-CMC_PRO_API_KEY": "6681b62a-9063-4881-a29a-8bb0f4ba2872"
      });
      var _myJson = json.decode(response.body);
      apiResp = _myJson["data"];
      len = apiResp.length;
      return apiResp;
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              var temp = await getAPI();
              setState(() {
                len = temp.length;
              });
              Fluttertoast.showToast(
                  msg: "Refresh Successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey.shade900,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
        title: Text("CryptoMoney"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAPI(),
        builder: (context, snapshot) {
          return _listBuilder(snapshot);
        },
      ),
    );
  }

  Widget _listBuilder(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      var data = snapshot.data;
      return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                child: Text(data[index]["name"][0]),
              ),
              title: Text(
                  data[index]["name"] + " (" + data[index]["symbol"] + ")"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "\$" +
                        data[index]["quote"]["USD"]["price"].toStringAsFixed(2),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Last Updated- " +
                        data[index]["last_updated"]
                            .toString()
                            .substring(11, 19),
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    data[index]["quote"]["USD"]["percent_change_1h"].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color:
                          data[index]["quote"]["USD"]["percent_change_1h"] < 0
                              ? Colors.red
                              : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
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
