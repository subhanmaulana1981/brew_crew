import 'dart:async';

import 'package:brew_crew/models/pengguna.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  Pengguna? _userFromFirebaseUser(User? user) {
    try {
      return (user != null) ? (Pengguna(uid: user.uid)) : null;
    } catch (e) {
      // print(e.toString());
    }
    return null;
  }

  // auth change user stream
  Stream<Pengguna>? get onAuthStateChanges {
    try {
      Stream<Pengguna> streamPengguna = _auth
          .authStateChanges()
          .map((User? user) => _userFromFirebaseUser(user)!);
      return streamPengguna;
    } catch (e) {
      // print(e.toString());
    }

    return null;
  }

  // sign in anonymous
  Future signInAnon() async {
    try {
      // AuthResult returns to UserCredential
      UserCredential result = await _auth.signInAnonymously();

      // FirebaseUser returns to User
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData("0", "new crew member", 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // print("error dari logout ${e.toString()}");
      return null;
    }
  }
}
