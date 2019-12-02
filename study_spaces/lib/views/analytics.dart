import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:study_spaces/util/barchart.dart';

class Analytics extends StatelessWidget {
  Analytics({Key key, this.title}) : super(key: key);


  final String title;

  @override
  Widget build(BuildContext context) {
    Widget bar = new BarChart.withSampleData();
    // Return App
    return new Scaffold(
      appBar: new AppBar(title: new Text('Barchart demo')),
      body: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(children: <Widget>[
            new SizedBox(height: 250.0, child: new BarChart.withSampleData()),
          ])),
    );
  }

}