


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_spaces/components/space_card.dart';
import 'package:study_spaces/data_models/space.dart';

class StudyStats extends StatefulWidget {
  StudyStats(this.userId);
  String userId;

  @override
  State<StudyStats> createState() => StudyStatsState();
}

class StudyStatsState extends State<StudyStats>{

  Widget _generateSpaceRow(StudySpace space) {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: SpacesCard(space, widget.userId));
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: new Text("Enter Information for new Study Space")),
      child: StreamBuilder(
        stream: Firestore.instance.collection('reviews').where('userId', isEqualTo: widget.userId).snapshots(),
        builder:(context, snapshot){
          return Column(
            children: <Widget>[
              Text("Your favorite place to study:"),
              Text("Your most productive study spot"),
              Text("Your least stressful study spot"),
              Text("Your quietest study spot")
            ],
          );
        }
      )
    );
  }
}