import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram_clone/services/repositories/user_repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userViewModel = ChangeNotifierProvider<UserViewModel>((ref) {
  return UserViewModel(reader: ref.read);
});

class UserViewModel extends ChangeNotifier {
  final Reader reader;
  bool is_loading;
  bool _logged_in;
  int _total_posts;
  int _total_followers;
  int _total_following;

  UserViewModel({
    required this.reader,
    this.is_loading = false,
  })  : _logged_in = false,
        _total_posts = 0,
        _total_followers = 0,
        _total_following = 0;

  //SET TOTAL POST
  set total_post (int total_post){
    _total_posts = total_post;
    notifyListeners();
  }

  //GET TOTAL POST
  int get total_post => _total_posts;

  //SET TOTAL FOLLOWERS
  set total_followers(int total_followers){
    _total_followers = total_followers;
    notifyListeners();
  }

  //GET TOTAL FOLLOWERS
  int get total_followers => _total_followers;

  //SET TOTAL FOLLOWING
  set total_following(int total_following){
    _total_following = total_following;
    notifyListeners();
  }

  //GET TOTAL FOLLOWING
  int get total_following => _total_following;

  set logged_in (bool logged_in){
    _logged_in = logged_in;
    notifyListeners();
  }
  bool get logged_in => _logged_in;

  Future<void> signInWithGoogle() async {
    this.is_loading = true;
    notifyListeners();

    await reader(userAccessRepositoryProvider).signInWithGoogle();

    this.is_loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await reader(userAccessRepositoryProvider).signOut();
    notifyListeners();
  }

  User? getCurrentUser() {
    return reader(userAccessRepositoryProvider).getCurrentUser();
  }
}
