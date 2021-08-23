import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergram_clone/models/owner_user_model.dart';

abstract class UserInterface {

  Stream<User?> get authStateChanges;
  Future<void> signInWithGoogle();
  // Future<void> createUserRecord(String username);
  User? getCurrentUser();
  Future<void> signOut();
  Future<OwnerUserModel?> getUserByOwnerId({required String owner_id});

}