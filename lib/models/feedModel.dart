import 'package:cloud_firestore/cloud_firestore.dart';

class FeedModel {
  String? mediaUrl;
  final String? username;
  final String? location;
  final String? description;
  final likes;
  final String? postId;
  final String? ownerId;

  FeedModel({
    this.mediaUrl,
    this.username,
    this.location,
    this.description,
    this.likes,
    this.postId,
    this.ownerId,
  });

  factory FeedModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return FeedModel(
      mediaUrl: documentSnapshot['mediaUrl'],
      username: documentSnapshot['username'],
      location: documentSnapshot['location'],
      description: documentSnapshot['description'],
      likes: documentSnapshot['likes'],
      postId: documentSnapshot.id,
      ownerId: documentSnapshot['ownerId'],
    );
  }

  factory FeedModel.fromJson(Map data) {
    return FeedModel(
      mediaUrl: data['mediaUrl'],
      username: data['username'],
      location: data['location'],
      description: data['description'],
      likes: data['likes'],
      postId: data["postId"],
      ownerId: data['ownerId'],
    );
  }


}
