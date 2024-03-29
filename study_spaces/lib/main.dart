import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:study_spaces/data_models/app_state.dart';
import 'package:study_spaces/util/authentication.dart';
import 'package:study_spaces/views/login.dart';
import 'package:study_spaces/views/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        home: RootScreen(auth: new Auth()),
//        home: LoginSignupScreen(),
      ),
    ),
  );
}
