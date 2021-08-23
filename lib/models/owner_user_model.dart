import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerUserModel {

  final String? photo_url;
  final String? username;

  OwnerUserModel({
    this.photo_url,
    this.username,
  });

  factory OwnerUserModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return OwnerUserModel(
      photo_url: documentSnapshot['photo_url'],
      username: documentSnapshot['username'],
    );
  }

}
