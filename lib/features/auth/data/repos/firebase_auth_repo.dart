import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:social_media_app/features/auth/domain/entites/app_user.dart';
import 'package:social_media_app/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    final currerntUser = firebaseAuth.currentUser;

    if (currerntUser == null) {
      return null;
    }
    return AppUser(uid: currerntUser.uid, name: '', email: currerntUser.email!);
  }

  @override
  Future<AppUser?> logInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        name: '',
        email: email,
      );
      return user;
    } catch (e) {
      throw Exception('log in faild : $e');
    }
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
      );

      try {
        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .set(user.toJson());
      } catch (firestoreError) {
        // User was created in Auth but failed to save to Firestore
        // Consider deleting the auth user or implementing retry logic
        await firebaseAuth.currentUser?.delete();
        throw Exception('Failed to save user data: $firestoreError');
      }
      return user;
    } catch (e) {
      throw Exception('resigter  failed : $e');
    }
  }
}
