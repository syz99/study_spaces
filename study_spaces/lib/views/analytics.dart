

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
    return new CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Study Statistics'),
        ),
      child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(children: <Widget>[
            new SizedBox(height: 250.0, child: bar),
          ])),
    );
  }

}
