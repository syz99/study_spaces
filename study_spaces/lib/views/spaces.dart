import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/space_card.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/data_models/space.dart';



class SpacesList extends StatelessWidget {

  Widget _generateSpaceRow(StudySpace space) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: FutureBuilder<Set<SpaceCategory>>(
          //future: prefs.preferredCategories,
          builder: (context, snapshot) {
            final data = snapshot.data ?? Set<SpaceCategory>();
            return SpacesCard(space);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        String dateString = DateFormat("MMMM y").format(DateTime.now());

        final appState =
        ScopedModel.of<AppState>(context, rebuildOnChange: true);

        return DecoratedBox(
          decoration: BoxDecoration(color: Color(0xffffffff)),
          child: ListView.builder(
            itemCount: appState.allSpaces.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dateString.toUpperCase()),
                      Text('Study Spaces'),
                    ],
                  ),
                );
              } else if (index <= appState.allSpaces.length) {
                return _generateSpaceRow(
                  appState.allSpaces[index - 1]
                );
              } else if (index <= appState.allSpaces.length + 1) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  //child: Text('Not in season'),
                );
              } else {
                int relativeIndex =
                    index - (appState.allSpaces.length + 2);
                return _generateSpaceRow(
                    appState.allSpaces[relativeIndex]);
              }
            },
          ),
        );
      },
    );
  }

}
