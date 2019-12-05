


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpaceDetail extends StatelessWidget{
  SpaceDetail(this.name);
  String name;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CupertinoPageScaffold(
      child: new Text(name)
    );
  }

}