// This is for Async data fetching


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/close_button.dart';
import 'package:study_spaces/components/review_card.dart';
import 'package:study_spaces/data_models/reviews.dart';
import 'package:study_spaces/data_models/space.dart';

import '../data_models/app_state.dart';

// ignore: must_be_immutable
class SpaceDetails extends StatefulWidget {
  SpaceDetails(this.id);

  int id;


  @override
  _SpaceDetailsState createState() => _SpaceDetailsState();
}

class _SpaceDetailsState extends State<SpaceDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}

//TODO: Add a list that breaks down every review of the user corresponding to that specific space! This will let the user know
// when they've studied in the space before and what their feelings about it were

