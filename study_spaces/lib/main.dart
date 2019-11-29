// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:veggieseasons/data/app_state.dart';
//import 'package:veggieseasons/data/preferences.dart';
import 'package:study_spaces/views/home.dart';
//import 'package:veggieseasons/styles.dart';

class MyApp extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

void main() => runApp(MyApp());
//void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
//
//  runApp(
//    ScopedModel<AppState>(
//      model: AppState(),
//      child: ScopedModel<Preferences>(
//        model: Preferences()..load(),
//        child: CupertinoApp(
//          debugShowCheckedModeBanner: false,
////          color: Styles.appBackground,
//          home: HomeScreen(),
//        ),
//      ),
//    ),
//  );
//}