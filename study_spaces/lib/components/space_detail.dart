


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/close_button.dart';
import 'package:study_spaces/components/review_card.dart';
import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/space.dart';
import 'package:study_spaces/views/timer_page.dart';

import '../data_models/app_state.dart';

class SpaceDetail extends StatefulWidget {
  SpaceDetail(this.id);

  int id;


  @override
  _SpaceDetailsState createState() => _SpaceDetailsState();
}

class _SpaceDetailsState extends State<SpaceDetail>{

  Widget _generateReviewRow(Review review) {
    //return ReviewCard(review);
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: FutureBuilder<Set<SpaceCategory>>(
          builder: (context, snapshot) {
            return ReviewCard(review);
          }),
    );
  }

  // DEFINE METHOD FOR BUILDING HEADER
  Widget _buildHeader(BuildContext context, AppState model) {
    final space = model.getSpace(widget.id);
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Image.asset(
              //space.imageAssetPath,
              space.imageUrl, // ADD IMAGE PATH TO DATA
              fit: BoxFit.cover,
              semanticLabel: 'A background image of ${space.name}',
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: CustomCloseButton(() {
                Navigator.of(context).pop();
              }),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final appState = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    final List<Review> reviews = appState.getReviewsFromSpace(widget.id) as List<Review>;

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, appState),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CupertinoButton(
              onPressed: () {
                Navigator.of(context).push<void>(CupertinoPageRoute(
                builder: (context) => TimerPage(space_id: widget.id),
                fullscreenDialog: true,
              ));},
              child: Text("Start Studying!"),
              color: Colors.red[300]
            )
          ),
         Expanded(
             child: DecoratedBox(
               decoration: BoxDecoration(color: Color(0xffffffff)),
               //height: 200.0,
               child: ListView.builder(
                 scrollDirection: Axis.vertical,
                 itemCount: reviews.length + 2,
                 itemBuilder: (context, index) {
                   if (index == 0) {
                     return Padding(
                       padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Your Reviews for ${appState.getSpace(widget.id).name}'),
                         ],
                       ),
                     );
                   } else if (index <= reviews.length) {
                     return _generateReviewRow(
                         reviews[index - 1]
                     );
                   } else if (index <= reviews.length + 1) {
                     return Padding(
                       padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                       //child: Text('Not in season'),
                     );
                   } else {
                     int relativeIndex = index - (reviews.length + 2);
                     return _generateReviewRow(reviews[relativeIndex]);
                   }
                 },
               ),
             )
         ),

          // Build My Header
        ],
      ),
    );
  }
}

//TODO: Add a list that breaks down every review of the user corresponding to that specific space! This will let the user know
// when they've studied in the space before and what their feelings about it were

