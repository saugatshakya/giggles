import 'package:Giggles/Profile/profile.dart';
import 'package:Giggles/Registration/loginpage.dart';
import 'package:Giggles/models/user.dart';
import 'package:Giggles/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  handleAuth () {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          return Profile();
        }
        else {
          return LoginPage();
        }
      }
    );
  }
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid): null;
  }
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  Future signOut() async {
    return await _auth.signOut();
  }

  Future signIn(AuthCredential authCreds) async {
    AuthResult result = await _auth.signInWithCredential(authCreds);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    AuthResult result = await _auth.signInWithCredential(authCreds);
    FirebaseUser user = result.user;
    final snapShot = await Firestore.instance.collection('users').document(user.uid).get();
    if(snapShot.exists) {

    }
    else{
      await DatabaseService(uid: user.uid).changeUserData("", "", "", "",Timestamp(0,0),GeoPoint(0.0,0.0));
    }
    return _userFromFirebaseUser(user);
  }

   Future<bool> isFirstTime(String userId) async {
    bool exist;
    await Firestore.instance.collection('users').document(userId).get().then((user) {exist = user.exists;});
    return exist;
  }
}