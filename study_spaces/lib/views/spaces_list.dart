import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/space_card.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/data_models/space.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpacesList extends StatelessWidget {
  Widget _generateSpaceRow(StudySpace space) {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: SpacesCard(space));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        String dateString = DateFormat("MMMM y").format(DateTime.now());
        return  DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffffffff)),
                child: StreamBuilder(
                    stream: Firestore.instance.collection('spaces').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
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
                                                      onPressed: () {},))),

                                          ]),
                                    ),
                                  ],
                                ),
                              );
                            } else if (index <=
                                snapshot.data.documents.length) {
                              DocumentSnapshot myspace =
                                  snapshot.data.documents[index];
                              return _generateSpaceRow(
                                  StudySpace.fromMap(myspace.data));
                            } else {
                              int relativeIndex =
                                  index - (snapshot.data.documents.length + 2);
                              DocumentSnapshot myspace =
                                  snapshot.data.documents[relativeIndex];
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
