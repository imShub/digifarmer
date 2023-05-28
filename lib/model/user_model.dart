import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final int phone;
  final String uid;
  final String username;
  // final List followers;
  // final List following;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.username,
    required this.uid,
    // required this.followers,
    // required this.following,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "name": name,
        "phone": phone,
        "username": username,
        // "followers": followers,
        // "following": following,
      };

  static UserModel? fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      name: snapshot['name'],
      phone: snapshot['phone'],
      // following: snapshot['following'],
      // followers: snapshot['followers'],
      email: snapshot['email'],
    );
  }
}
