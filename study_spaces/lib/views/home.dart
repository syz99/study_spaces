// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/util/authentication.dart';
import 'package:study_spaces/views/login.dart';
import 'package:study_spaces/views/login_signup.dart';
import 'package:study_spaces/views/search_spaces.dart';
import 'package:study_spaces/views/spaces_list.dart';
import 'package:study_spaces/views/study_stats.dart';

import 'analytics.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({
    Key key,
    this.auth,
    this.userId,
    this.logoutCallback,
  }) : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

/// Main screen post-login/signup
class HomeScreenState extends State<HomeScreen>{

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: AppState(),
      child: CupertinoTabScaffold(

    //return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text('Spaces'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                title: Text('Map Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                title: Text('Analytics'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                title: Text('Log Out'),
              ),
            ],
         ),
        tabBuilder: (context, index) {
          if (index == 0) {
            return SpacesList(widget.userId);
          }
          else if (index == 1) {
            return SearchSpaces(widget.userId);
          }
           else if (index == 2) {
            //return Analytics();
            return StudyStats(widget.userId);
          } else {
             signOut();
             return LoginSignupScreen();
          }
        },
      )
    );
  }
}