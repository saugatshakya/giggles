import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Giggles/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  
  //collection reference
  final CollectionReference userDataCollection = Firestore.instance.collection('users');

  Future changeUserData(String name,String gender,String interestedIn,String photo,Timestamp age,GeoPoint location,)async {
    return await userDataCollection.document(uid).setData({
      'name': name,
      'age': age,
      'gender': gender,
      'interestedIn': interestedIn,
      'photo': photo,
      'location' : location
    });
  }

  Stream<User> get userData {
    return userDataCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      name: snapshot.data['name'],
      age: snapshot.data['age'],
      gender: snapshot.data['gender'],
      interestedIn: snapshot.data['interestedIn'],
      photo: snapshot.data['photo'],
      location : snapshot.data['location']
    );
  }
}