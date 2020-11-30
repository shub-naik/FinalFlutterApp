import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsInfo extends StatefulWidget {
  @override
  _NewsInfoState createState() => _NewsInfoState();
}

class _NewsInfoState extends State<NewsInfo> {
  List<dynamic> result = List<dynamic>();
  Future<List<dynamic>> getNewsinfo() async {
    Response response = await get(
      'https://newsapi.org/v2/everything?apiKey=9954a562c4124486afc2234966d0132d&q=agriculture',
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      result.addAll(data['articles']);
      print(result);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('News Info'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Title: " + result[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description: " + result[index]['description'],
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text("Content: " + result[index]['content']),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: getNewsinfo(),
      ),
    );
  }
}
