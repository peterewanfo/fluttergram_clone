import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergram_clone/models/owner_user_model.dart';
import 'package:fluttergram_clone/services/interfaces/user_interface.dart';
import 'package:fluttergram_clone/view_model/firebase_providers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userAccessRepositoryProvider =
    Provider<UserRepositories>((ref) => UserRepositories(ref.read));

class UserRepositories implements UserInterface {
  final Reader _reader;

  UserRepositories(this._reader);

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();

      if (_reader(firebaseAuthProvider).currentUser == null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount!.authentication;

        final credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        await _reader(firebaseAuthProvider).signInWithCredential(credentials);
      } else {
        //SIGN IN SILENTLY
        await googleSignIn.signInSilently();
      }
    } catch (err, str) {
      print("Error log:" + err.toString());
      return null;
    }
  }

  // @override
  // Future<UserModel> createUserRecord(String username) async{
  //   GoogleSignInAccount user = googleSignIn.currentUser;
  //   if (user == null) {
  //     return null;
  //   }
  //   DocumentSnapshot userRecord = await ref.doc(user.id).get();
  //
  //   if (userRecord.data() == null) {
  //
  //     ref.doc(user.id).set({
  //       "id": user.id,
  //       "username": username,
  //       "photoUrl": user.photoUrl,
  //       "email": user.email,
  //       "displayName": user.displayName,
  //       "bio": "",
  //       "followers": {},
  //       "following": {},
  //     });
  //
  //     userRecord = await ref.doc(user.id).get();
  //
  //     UserModel currentUserModel = UserModel.fromDocument(userRecord);
  //
  //     return currentUserModel;
  //
  //   }
  //   return null;
  //
  // }

  @override
  Stream<User?> get authStateChanges =>
      _reader(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() => _reader(firebaseAuthProvider).currentUser;

  @override
  Future<void> signOut() async {
    await googleSignIn.disconnect();
    _reader(firebaseAuthProvider).signOut();
  }

  @override
  Future<OwnerUserModel?> getUserByOwnerId({required String owner_id}) async{

    try {

      final snap = await _reader(firebaseFirestoreProvider)
          .collection('insta_users')
          .doc(owner_id)
          .get();

      OwnerUserModel ownerUserModel =  OwnerUserModel.fromDocument(snap);

      return ownerUserModel;

    } catch (e) {
      print(e.toString() + "-----");
      throw Exception("An error occured");
    }

  }
}
