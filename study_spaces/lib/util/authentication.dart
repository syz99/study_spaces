import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

/// abstract class representing functionality for users logging in / signin up
abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}

/// Implements BaseAuth features of signing up / logging in
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// signs a user in with the given username and password
  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
    );
    FirebaseUser user = result.user;
    return user.uid;
  }

  /// signs a user up with the given username and password
  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password
    );
    FirebaseUser user = result.user;
    return user.uid;
  }

  /// returns the current Firebaseuser object
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  /// signs the current user out
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  /// sends users email verification to the given email
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  /// return whether or not the email is verified
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}