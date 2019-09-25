import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServicies {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = 'users';

  void createUsers(Map value) {
    String key = value['userId'];
    _database.reference().child('$ref/$key').push().set(value).catchError((e) {
      print("DBUSERS"+e.toString());
    });
  }
}
