import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _ProfileState createState() {
    // TODO: implement createState
    return new _ProfileState();
  }

}

class _ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Profile'),
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

