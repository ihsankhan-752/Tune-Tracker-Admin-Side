import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;

  UserModel({required this.uid, required this.email, required this.username});

  factory UserModel.fromDoc(DocumentSnapshot snap) {
    return UserModel(
      uid: snap['uid'],
      email: snap['email'],
      username: snap['username'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}
