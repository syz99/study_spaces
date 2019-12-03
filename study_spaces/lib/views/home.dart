// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/views/search_spaces.dart';
import 'package:study_spaces/views/settings.dart';
import 'package:study_spaces/views/spaces.dart';

import 'analytics.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: AppState(),
      child: CupertinoTabScaffold(


    //return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          title: Text('Spaces'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          title: Text('Map Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          title: Text('Analytics'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          title: Text('Settings'),
        ),
      ]),
      tabBuilder: (context, index) {
        if (index == 0) {
          return SpacesList();
        }
        else if (index == 1) {
          return SearchSpaces();
        }
         else if (index == 2) {
          return Analytics();
        } else {
          return Settings();
        }
      },
    )
    );
  }
}