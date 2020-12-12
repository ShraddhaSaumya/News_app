import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CcPage extends StatefulWidget {
  @override
  _CcPageState createState() => _CcPageState();
}

int len = 0;

class _CcPageState extends State<CcPage> {
  @override
  Widget build(BuildContext context) {
    var apiRes;

    Future<List<dynamic>> getApi() async {
      String url =
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
      var response = await http.get(url, headers: {
        "X-CMC_PRO_API_KEY": "e929e673-12da-45fc-86f5-89a77993ed31"
      });
      var _json = json.decode(response.body);
      apiRes = _json["data"];
      len = apiRes.length;
      return apiRes;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("CRYPTOCURRENCY"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.monetization_on),
              onPressed: () async {
                var temp = await getApi();
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
      body: FutureBuilder(
          future: getApi(),
          builder: (context, snapshot) {
            return _apiWidget(snapshot);
          }),
    );
  }
}

Widget _apiWidget(AsyncSnapshot snapshot) {
  if (snapshot.connectionState == ConnectionState.done) {
    var data = snapshot.data;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.blue[700],
          elevation: 5,
          child: ListTile(
            title: Text(data[index]["name"]),
            leading: CircleAvatar(
              foregroundColor: Colors.orange.shade800,
              backgroundColor: Colors.lightBlueAccent,
              child: Text(data[index]["name"][0]),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(data[index]["symbol"]),
                Text(data[index]["cmc_rank"].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
            subtitle: Text(data[index]["slug"]),
          ),
        );
      },
      itemCount: len,
    );
  } else
    return Center(child: CircularProgressIndicator());
}
