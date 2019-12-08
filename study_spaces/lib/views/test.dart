import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_spaces/views/home.dart';
import 'package:study_spaces/util/data_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

class TestScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>{
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future<String> fetchData(){
    return Future.delayed(Duration(seconds: 4), () => 'Large Latte');
  }
  @override
  Widget build(BuildContext context) {
    Future<String> s = fetchData();
    final emailField = CupertinoTextField(
      placeholder: "Email",
      obscureText: false,
      style: style,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black26)),
    );
    final passwordField = CupertinoTextField(
      placeholder: "Password",
      obscureText: true,
      style: style,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black26)),
    );
    final mainText = Text("HELLO WORLD",
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold));

    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                mainText,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


