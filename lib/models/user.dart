import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String gender;
  String interestedIn;
  String photo;
  Timestamp age;
  GeoPoint location;

  User({
    this.uid,
    this.age,
    this.gender,
    this.interestedIn,
    this.location,
    this.name,
    this.photo
  });
}