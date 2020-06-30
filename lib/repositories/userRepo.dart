import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepo({
    FirebaseAuth firebaseAuth,
    Firestore firestore
  }): _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? Firestore.instance;

  Future<bool> isFirstTime(String userId) async {
    bool exist;
    await Firestore.instance.collection('users').document(userId).get().then((user) {exist = user.exists;});
    return exist;
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}