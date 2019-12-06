


import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/components/close_button.dart';

import 'app_state.dart';

class SpaceDetail extends StatefulWidget {
  SpaceDetail(this.id);

  int id;


  @override
  _SpaceDetailsState createState() => _SpaceDetailsState();
}

class _SpaceDetailsState extends State<SpaceDetail>{

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
              "images/perkins.png", // ADD IMAGE PATH TO DATA
              fit: BoxFit.cover,
              semanticLabel: 'A background image of ${space.name}',
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: CloseButton(() {
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

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, appState), // Build My Header
        ],
      ),
    );
  }
}


