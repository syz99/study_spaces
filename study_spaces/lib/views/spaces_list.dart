import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/space_card.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/data_models/space.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:async/async.dart';
import 'add_space.dart';

class SpacesList extends StatelessWidget {
  SpacesList(this.userId);

  String userId;

  Widget _generateSpaceRow(StudySpace space) {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: SpacesCard(space, userId));
  }


  Widget topInfo(String dateString,BuildContext context){
    return Padding(
      padding:
      const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dateString.toUpperCase()),
          new SizedBox(
            height: 40,
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Study Spaces'),
                  SizedBox(
                      height: 40,
                      width: 100,
                      child: Container(
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            child: new Text('Add a new space'),
                            textColor: Colors.red,
                            onPressed: () {
                              Navigator.of(context).push<void>(CupertinoPageRoute(
                                builder: (context) => AddSpace(this.userId),
                                fullscreenDialog: true,
                              ));
                            },))),

                ]),
          ),
        ],
      ),
    );
  }
//  List<QuerySnapshot> getData() {
//    Stream stream2 = Firestore.instance.collection('spaces').where('userUID', isEqualTo: userId).snapshots();
//    Stream stream1 = Firestore.instance.collection('spaces').where('userUID', isEqualTo: null).snapshots();
//    return stream1;
//    //return StreamZip([stream2, stream1]);
//  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        String dateString = DateFormat("MMMM y").format(DateTime.now());
        return  DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffffffff)),
                child: StreamBuilder(
                    //stream: getData(),
                  stream: Firestore.instance.collection('spaces').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        //return Text('Loading');
                        return CircularProgressIndicator();
                      } else {

                        //MOVE ALL DOCUMENTS FROM [1] OVER TO [0]
                        print(snapshot);
                        List<DocumentSnapshot> docs = [];
                        for (DocumentSnapshot doc in snapshot.data.documents){
                          print(doc.data['userUID']);
                          if(doc.data['userUID'] != null){
                            if(doc.data['userUID'] != userId){
                              continue;
                            }
                          }
                          docs.add(doc);
                          //snapshot.data[0].documents.add(doc);
                        }
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return topInfo(dateString, context);
                            } if (index <=
                                docs.length) {
                              DocumentSnapshot myspace =
                                  docs[index];
                              return _generateSpaceRow(
                                  StudySpace.fromMap(myspace.data));
                            } else {
                              int relativeIndex =
                                  index - (docs.length + 2);
                              DocumentSnapshot myspace =
                                  docs[relativeIndex];
                              return _generateSpaceRow(
                                  StudySpace.fromMap(myspace.data));
                            }
                          },
                        );
                      }
                    }
                    )
        );
      },
    );
  }
}
