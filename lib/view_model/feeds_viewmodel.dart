import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram_clone/models/feedModel.dart';
import 'package:fluttergram_clone/services/repositories/feed_repositories.dart';
import 'package:fluttergram_clone/services/repositories/user_repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final feedViewModel = ChangeNotifierProvider<FeedsViewModel>((ref) {
  return FeedsViewModel(reader: ref.read);
});

class FeedsViewModel extends ChangeNotifier {
  final Reader reader;
  bool _isImageUploading;
  String _likeClicked;

  FeedsViewModel({
    required this.reader,
  })   : _isImageUploading = false,
        _likeClicked = "";

  bool get isImageUploading => _isImageUploading;
  set isImageUploading(bool file) {
    _isImageUploading = file;
    notifyListeners();
  }

  String get likeClicked => _likeClicked;
  set likeClicked(String likeClicked) {
    _likeClicked = likeClicked;
    notifyListeners();
  }

  Future<void> uploadContent(File file, FeedModel feedModel) async {
    this.isImageUploading = true;

    var download_url =
        await reader(feedsRepositoryProvider).uploadFile(imageFile: file);

    feedModel.mediaUrl = download_url;

    await reader(feedsRepositoryProvider).createFeed(feedModel: feedModel);

    this.isImageUploading = false;
  }

  Future<void> likeContent(String username, String postId, bool action) async {

    this.likeClicked = postId;

    await reader(feedsRepositoryProvider)
        .likeFeed(username: username, postId: postId, action: action);

    this.likeClicked = "";

  }
}
