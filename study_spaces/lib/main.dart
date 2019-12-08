// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/views/home.dart';
import 'package:study_spaces/views/login.dart';
import 'package:study_spaces/views/login_signup.dart';
import 'data_models/app_state.dart';

//class MyApp extends StatelessWidget{
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Study Spaces',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: LoginSignupScreen(),
//    );
//  }
//}
//
//void main() => runApp(MyApp());

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final model = AppState();
  runApp(
    ScopedModel<AppState>(
      model: model,
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        color: Color(0xffd0d0d0),
        home: LoginScreen(),
//        home: LoginSignupScreen(),
      ),
    ),
  );
}

