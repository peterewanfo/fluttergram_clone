import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttergram_clone/models/feedModel.dart';
import 'package:fluttergram_clone/services/interfaces/feeds_interface.dart';
import 'package:fluttergram_clone/view_model/firebase_providers.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

final feedsRepositoryProvider =
    Provider<FeedRepositories>((ref) => FeedRepositories(ref.read));

class FeedRepositories implements FeedsInterface {
  final Reader _reader;

  FeedRepositories(this._reader);

  @override
  Future<void> createFeed(
      {required FeedModel feedModel}) async{

    var reference = await _reader(firebaseFirestoreProvider)
        .collection("insta_posts");

    reference.add({
      "username": feedModel.username,
      "location": feedModel.location,
      "likes": {},
      "mediaUrl": feedModel.mediaUrl,
      "description": feedModel.description,
      "ownerId": feedModel.ownerId,
      "timestamp": DateTime.now(),
    }).then((DocumentReference doc) {
      String docId = doc.id;
      reference.doc(docId).update({"postId": docId});
    });

  }

  @override
  Future<void> deleteNewsFeed(
      {required String username, required String postId}) {
    // TODO: implement deleteNewsFeed
    throw UnimplementedError();
  }

  @override
  Future<List<FeedModel>> fetchAllFeeds({required String username}) {
    // TODO: implement fetchAllFeeds
    throw UnimplementedError();
  }

  @override
  Future<List<FeedModel>> getUserPost({required String profileId}) async {
    try {
      List<FeedModel> posts = [];

      final snap = await _reader(firebaseFirestoreProvider)
          .collection("insta_posts")
          .where('ownerId', isEqualTo: profileId)
          .orderBy("timestamp")
          .get();

      for (var doc in snap.docs) {
        print("post here");
        posts.add(FeedModel.fromDocument(doc));
      }

      _reader(userViewModel).total_post = posts.length;

      print(posts.length.toString());

      return posts.reversed.toList();
    } catch (e) {
      print(e.toString() + "-----");
      throw Exception("An error occured");
    }

  }

  @override
  Future<String> uploadFile({required var imageFile}) async {
    try {
      var uuid = Uuid().v1();

      Reference ref =
          await _reader(firebaseStorageProvider).ref().child("post_$uuid.jpg");

      UploadTask uploadTask = ref.putFile(imageFile);

      String downloadUrl = await (await uploadTask).ref.getDownloadURL();
      return downloadUrl;

    } catch (e) {
      print(e.toString() + "-----");
      throw Exception("An error occured");
    }
  }

  @override
  Future<void> likeFeed({required String username, required String postId, required bool action }) async{

    try {

      await _reader(firebaseFirestoreProvider)
          .collection("insta_posts")
          .doc(postId).update({
        'likes.$username': action
      });

    } catch (e) {
      print(e.toString() + "-----");
      throw Exception("An error occured");
    }

  }
}
