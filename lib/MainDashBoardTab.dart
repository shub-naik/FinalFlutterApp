import 'dart:convert';
import 'package:flutter/material.dart';

class MainDashBoardTab extends StatefulWidget {
  @override
  _MainDashBoardTabState createState() => _MainDashBoardTabState();
}

class _MainDashBoardTabState extends State<MainDashBoardTab> {
  List<dynamic> data;

  preventiveMeasuresFun(List<dynamic> d) {
    String s = "";
    int i = 0;
    d.forEach((element) {
      if (i == 0) {
        s += "\n";
        i = 1;
      }
      s += "\t\t\t\t ⦿" + element + "\n\n";
    });
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // Use future builder and DefaultAssetBundle to load the local JSON file
        child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/data.json'),
            builder: (context, snapshot) {
              // Decode the JSON
              var new_data = json.decode(snapshot.data.toString());
              return ListView.builder(
                // Build the ListView
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Name: " + new_data[index]['name']),
                          SizedBox(
                            height: 10,
                          ),
                          Text("symptoms: " + new_data[index]['symptoms']),
                          SizedBox(
                            height: 10,
                          ),
                          Text("preventive_measures: " +
                              preventiveMeasuresFun(
                                  new_data[index]['preventive_measures']))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: new_data == null ? 0 : new_data.length,
              );
            }),
      ),
    );
    ;
  }
}
