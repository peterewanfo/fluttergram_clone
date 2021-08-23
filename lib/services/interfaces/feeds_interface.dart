

import 'package:fluttergram_clone/models/feedModel.dart';

abstract class FeedsInterface {

  Future<List<FeedModel>> fetchAllFeeds({required String username});
  Future<void> createFeed({required FeedModel feedModel});
  Future<void> deleteNewsFeed({required String username, required String postId});
  Future<List<FeedModel>> getUserPost({required String profileId});
  Future<String> uploadFile({required var imageFile});
  Future<void> likeFeed({required String username, required String postId, required bool action});


}