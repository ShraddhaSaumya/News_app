import 'dart:convert';
import 'package:api_app/News/news.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CcPage extends StatefulWidget {
  @override
  _CcPageState createState() => _CcPageState();
}

int len = 0;

class _CcPageState extends State<CcPage> with TickerProviderStateMixin {
  TabController tabCont;

  @override
  void initState() {
    super.initState();
    tabCont=new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apiRes;

    Future<List<dynamic>> getApi(String url) async {
      var response = await http.get(url, headers: {
        "X-CMC_PRO_API_KEY": "e929e673-12da-45fc-86f5-89a77993ed31"
      });
      var _json = json.decode(response.body);
      apiRes = _json["data"];
      len = apiRes.length;
      return apiRes;
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: Material(
          color: Colors.grey[100],
          child: TabBar(
            labelColor: Colors.blue,
            controller: tabCont,
            tabs: <Widget>[
              Icon(Icons.monetization_on_rounded,size:26,),
              Icon(Icons.money,size:26,),
              Icon(Icons.more,size:26,),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Stock Feed"),
        centerTitle: true,
        actions: <Widget>[
          
          IconButton(
              icon: Icon(Icons.monetization_on),
              onPressed: () async {
                var temp = await getApi(url);
                setState(() {
                  len = temp.length;
                });
                Fluttertoast.showToast(
                    msg: "Refreshed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.blue[300],
                    textColor: Colors.white,
                    fontSize: 12.0);
              })
        ],
      ),
      body: TabBarView(
        controller: tabCont,
        children: [
          FutureBuilder(
          future: getApi("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"),
          builder: (context, snapshot) {
            return _apiWidget(snapshot);
          }),
          FutureBuilder(
          future: getApi("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"),
          builder: (context, snapshot) {
            
            return _apiWidget(snapshot);
          }),
          FutureBuilder(
          future: getApi("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"),
          builder: (context, snapshot) {
            return _apiWidget(snapshot);
          }), 
        ],
    ));
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
          shadowColor: Colors.blue[700],
          elevation: 5,
          child: _listItem(data, index),
        );
      },
      itemCount: len,
    );
  } else
    return Center(child: CircularProgressIndicator());
}

Widget size = SizedBox(height: 5);

Widget _listItem(data, index) {
  return ExpansionTile(
    title: Text(data[index]["name"], style: TextStyle(fontSize: 17)),
    subtitle: (data[index]["quote"]["USD"]["percent_change_24h"] >= 0
        ? Text(
            data[index]["quote"]["USD"]["percent_change_24h"]
                    .toStringAsFixed(3) +
                "%",
            style: TextStyle(fontSize: 15, color: Colors.green[700]))
        : Text(
            data[index]["quote"]["USD"]["percent_change_24h"]
                    .toStringAsFixed(3) +
                "%",
            style: TextStyle(fontSize: 15, color: Colors.red[600]))),
    leading: CircleAvatar(
      foregroundColor: Colors.orange.shade800,
      backgroundColor: Colors.lightBlueAccent,
      child: Text(data[index]["name"][0]),
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(data[index]["symbol"]),
        Text(
          "\$" + data[index]["quote"]["USD"]["price"].toStringAsFixed(2),
          style: TextStyle(fontSize: 17, color: Colors.blue[700]),
        ),
        Text(
          data[index]["cmc_rank"].toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text("Max supply: " + data[index]["max_supply"].toString()),
              size,
              Text("Circ supply: " +
                  (data[index]["circulating_supply"]).round().toString())
            ]),
            Column(
              children: [
                Text("Market Capital: \$" +
                    (data[index]["quote"]["USD"]["market_cap"] / 1000000)
                        .round()
                        .toString() +
                    " Mn"),
                size,
                Text("Total supply: " +
                    data[index]["total_supply"].round().toString()),
              ],
            )
          ],
        ),
      )
    ],
  );
}
