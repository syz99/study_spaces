


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  int number_times;
  StudySpace mostProductive;
  StudySpace leastStressful;
  StudySpace mostQuiet;


  LinkedHashMap sortMap(Map countMap){
    var sortedKeys = countMap.keys.toList(growable:false)
      ..sort((k1, k2) => countMap[k1].compareTo(countMap[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => countMap[k]);
    return sortedMap;
  }

  //Returns users most common study spaces
  mostCommonStudy(List<String> spaceIds) async{
    var countMap = new Map();
    for(var id in spaceIds){
      if (countMap.containsKey(id)){
        countMap[id] += 1;
      }
      else{
        countMap[id] = 1;
      }
    }
    LinkedHashMap sortedMap = sortMap(countMap);
    String mostCommon = sortedMap.keys.toList().last;
    int num = sortedMap.values.toList().last;
    print(sortedMap.values.toList());
    //print(num);

    // Fetch that space form db
    DocumentSnapshot mostCommonStudySpace = await Firestore.instance
        .collection("spaces").document(mostCommon).get();
    //return StudySpace.fromMap(mostCommonStudy.data);
    setState(() {
      mostCommonSpace = StudySpace.fromMap(mostCommonStudySpace.data);
      number_times = num;
    });
  }


  int enumToNumber(String s){
    if(s.contains("NOT_PRODUCTIVE")){
      return 1;
    }
    else if(s.contains("PRODUCTIVE")){
      return 2;
    }
    else if(s.contains("LOW")){
      return 1;
    }
    else if(s.contains("AVERAGE")) {
      return 2;
    }
    else{
      return 3;
    }
  }

  getOtherStats(List<Review> reviews, List<String> spaceIds) async{
    var prodMap = new Map();
    var stressMap = new Map();
    var noiseMap = new Map();
    for (Review review in reviews){
      if(prodMap.containsKey(review.spaceId)){prodMap[review.spaceId] += enumToNumber(review.productivity.toString());}
      else{prodMap[review.spaceId] = enumToNumber(review.productivity.toString());}
      if(stressMap.containsKey(review.spaceId)){stressMap[review.spaceId] += enumToNumber(review.stress.toString());}
      else{stressMap[review.spaceId] = enumToNumber(review.stress.toString());}
      if(noiseMap.containsKey(review.spaceId)){noiseMap[review.spaceId] += enumToNumber(review.noiseLevel.toString());}
      else{noiseMap[review.spaceId] = enumToNumber(review.noiseLevel.toString());}
    }
//    var sortedProdMap = sortMap(prodMap);
//    var sortedStressMap = sortMap(stressMap);
//    var sortedNoiseMap = sortMap(noiseMap);
    String highestProd = sortMap(prodMap).keys.toList().last;
    String lowestStress = sortMap(stressMap).keys.toList()[0];
    String lowestNoise = sortMap(noiseMap).keys.toList()[0];


    DocumentSnapshot mostProd = await Firestore.instance
        .collection("spaces").document(highestProd).get();
    DocumentSnapshot leastStress = await Firestore.instance
        .collection("spaces").document(lowestStress).get();
    DocumentSnapshot leastNoise = await Firestore.instance
        .collection("spaces").document(lowestNoise).get();

    print(mostProd.data);

    setState(() {
      mostProductive = StudySpace.fromMap(mostProd.data);
      mostQuiet = StudySpace.fromMap(leastNoise.data);
      leastStressful = StudySpace.fromMap(leastStress.data);
    });
  }



  Widget _generateSpaceRow(StudySpace space) {
    if (space == null){
      return Text("...");
    }
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: SpacesCard(space, widget.userId));
  }

  Widget getTextButtons(String words, int number){
    TextStyle roundTextStyle =const TextStyle(fontSize: 25.0, color: Colors.redAccent);
    return FlatButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.redAccent)),
        child: new Text(words + ' ${number}', style: roundTextStyle),
        textColor: Colors.red,
        onPressed: () {}
    );
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
            return CircularProgressIndicator();
          }
          else{
            List<Review> reviews = [];
            List<String> spaceIds = [];
            for(DocumentSnapshot doc in snapshot.data.documents){
              reviews.add(Review.fromMap(doc.data));
              spaceIds.add(doc['spaceId']);
            }
            mostCommonStudy(spaceIds);
            getOtherStats(reviews, spaceIds);

            //print(mostCommonSpace);
            if (mostCommonSpace == null) {
              return Text("...");
            }
            else{
              return ListView(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                      child: getTextButtons("Your Favorite Place to Study",number_times)
                  ),
                  _generateSpaceRow(mostCommonSpace),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: getTextButtons("Your Most Productive Spot", number_times)
                  ),
                  _generateSpaceRow(mostProductive),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: getTextButtons("Your Least Stressful Spot",number_times)
                  ),
                  _generateSpaceRow(leastStressful),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: getTextButtons("Your Quietest Spot",number_times)
                  ),
                  _generateSpaceRow(mostQuiet),
                ],
              );
            }

          }

        }
      )
    );
  }
}