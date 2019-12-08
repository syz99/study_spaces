import 'package:flutter/cupertino.dart';
import 'package:study_spaces/util/BaseAuth.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootScreen extends StatefulWidget {

  RootScreen({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }



}