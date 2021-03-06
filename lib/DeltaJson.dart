import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class DeltaJson extends StatefulWidget {
  const DeltaJson({Key? key}) : super(key: key);

  @override
  _DeltaJsonState createState() => _DeltaJsonState();
}

class _DeltaJsonState extends State<DeltaJson> {
  final String url = "https://api.covid19india.org/data.json";
  late List data;
  bool isData = false;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response =
    await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      data = jsonDecode(response.body)['statewise'];
      isData = true;
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return isData
        ? ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          //    Text(''),
                              Text("State: "),
                              Text("Active Case: "),
                              Text("Confirmed Case: "),
                              Text("Total recovered: "),
                              Text("Total death: "),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      //        Text(data[index]['lastupdatedtime'],style: TextStyle(color: Colors.grey),),
                              Text(data[index]['state']),
                              Text(data[index]['active']),
                              Text(data[index]['deltaconfirmed']),
                              Text(data[index]['deltarecovered']),
                              Text(data[index]['deltadeaths']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        })
        : Center(
      child: CircularProgressIndicator(),
    );
  }
}
