


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_spaces/components/space_card.dart';
import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/space.dart';

class StudyStats extends StatefulWidget {
  StudyStats(this.userId);
  String userId;

  @override
  State<StudyStats> createState() => StudyStatsState();
}

class StudyStatsState extends State<StudyStats>{

  StudySpace mostCommonSpace;
  //Returns users most common study spaces
  mostCommonStudy(List<String> spaceIds) async{
    var countMap = new Map();
    for(var id in spaceIds){
      if (countMap.containsKey(id)){
        countMap[id] += 1;
      }
      countMap[id] = 0;
    }
    var sortedKeys = countMap.keys.toList(growable:false)
      ..sort((k1, k2) => countMap[k1].compareTo(countMap[k2]));

    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => countMap[k]);
    String mostCommon = sortedMap.keys.toList()[0];

    // Fetch that space form db
    DocumentSnapshot mostCommonStudySpace = await Firestore.instance
        .collection("spaces").document(mostCommon).get();
    //return StudySpace.fromMap(mostCommonStudy.data);
    setState(() {
      mostCommonSpace = StudySpace.fromMap(mostCommonStudySpace.data);
    });
  }



  Widget _generateSpaceRow(StudySpace space) {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: SpacesCard(space, widget.userId));
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
//      navigationBar: CupertinoNavigationBar(
//      heroTag: "statistic", transitionBetweenRoutes: false),
      child: StreamBuilder(
        stream: Firestore.instance.collection('reviews').where('userId', isEqualTo: widget.userId).snapshots(),
        builder:(context, snapshot){
          if (!snapshot.hasData) {
            //return Text('Loading');
            print("help");
            return Text("Loading");
          }
          else{
            List<Review> reviews = [];
            List<String> spaceIds = [];
            for(DocumentSnapshot doc in snapshot.data.documents){
              reviews.add(Review.fromMap(doc.data));
              spaceIds.add(doc['spaceId']);
            }
            mostCommonStudy(spaceIds);

            //print(mostCommonSpace);
            if (mostCommonSpace == null) {
              return Text("Loading");
            }
            else{
              return Column(
                children: <Widget>[
                  new Container(
                      height: 100.0,
                      child: new Center(
                        child: Text("Your favorite place to study:"),
                      )),
                  _generateSpaceRow(mostCommonSpace),
                  Text("Your most productive study spot"),
                  Text("Your least stressful study spot"),
                  Text("Your quietest study spot"),
                ],
              );
            }

          }

        }
      )
    );
  }
}