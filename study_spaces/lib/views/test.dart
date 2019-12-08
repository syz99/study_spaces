import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_spaces/views/home.dart';
import 'package:study_spaces/util/data_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

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
       return new Scaffold(
         body:  StreamBuilder(
             stream: db.collection('spaces').snapshots(),
             builder: (context, snapshot){
               if(!snapshot.hasData){
                 const Text('Loading');
               }
               return ListView.builder(
                 itemCount: snapshot.data.documents.length,
                 itemBuilder: (context, index){
                   DocumentSnapshot myspace = snapshot.data.documents[index];
                   return Text(myspace['name']);
                 },
               );
             }
         )
       );
  }
}


