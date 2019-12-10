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
  Stream<List<QuerySnapshot>> getData() {
    Stream stream1 = Firestore.instance.collection('spaces').where('userId', isEqualTo: null).snapshots();
    Stream stream2 = Firestore.instance.collection('spaces').where('userId', isEqualTo: userId).snapshots();
    return StreamZip([stream1, stream2]);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        String dateString = DateFormat("MMMM y").format(DateTime.now());
        return  DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffffffff)),
                child: StreamBuilder(
                    stream: getData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        //return Text('Loading');
                        print("help");
                        return topInfo(dateString,context);
                      } else {

                        //MOVE ALL DOCUMENTS FROM [1] OVER TO [0]
                        for (DocumentSnapshot doc in snapshot.data[1].documents){
                          snapshot.data[0].documents.add(doc);
                        }
                        return ListView.builder(
                          itemCount: snapshot.data[0].documents.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return topInfo(dateString, context);
                            } else if (index <=
                                snapshot.data[0].documents.length) {
                              DocumentSnapshot myspace =
                                  snapshot.data[0].documents[index];
                              return _generateSpaceRow(
                                  StudySpace.fromMap(myspace.data));
                            } else {
                              int relativeIndex =
                                  index - (snapshot.data[0].documents.length + 2);
                              DocumentSnapshot myspace =
                                  snapshot.data[0].documents[relativeIndex];
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
