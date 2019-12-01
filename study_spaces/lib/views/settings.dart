import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _SettingsState createState() {
    // TODO: implement createState
    return new _SettingsState();
  }

}

class _SettingsState extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Settings'),
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