import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Analytics extends StatefulWidget {
  Analytics({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _AnalyticsState createState() {
    // TODO: implement createState
    return new _AnalyticsState();
  }

}

class _AnalyticsState extends State<Analytics>{
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Analytics'),
          ),
          child: Center(
            child: true
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Nothing',
              ),
            ) : true,
          ),
        );
      },
    );
  }
}