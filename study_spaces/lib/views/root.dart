import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_spaces/util/BaseAuth.dart';
import 'package:study_spaces/views/home.dart';
import 'package:study_spaces/views/login_signup.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootScreen extends StatefulWidget {

  RootScreen({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new RootScreenState();
}

class RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  /// on load, RootScreen will get the userid and set AuthStatus
  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        _authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  /// callback function for logging in (sets AuthStatus to LOGGED_IN then directs to HomeScreen
  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });

    setState(() {
      _authStatus = AuthStatus.LOGGED_IN;
    });
  }

  /// callback function for logging out (sets AuthStatus to NOT_LOGGING_IN)
  void logoutCallback() {
    setState(() {
      _authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  /// builds our page according to AuthStatus
  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupScreen(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomeScreen(
            auth: widget.auth,
            userId: _userId,
            logoutCallback: logoutCallback,
          );
        }
        break;
      default:
        return buildWaitingScreen();
    }
  }

  /// builds waiting screen for when user auth is not either loggin or out
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
    );
  }
}