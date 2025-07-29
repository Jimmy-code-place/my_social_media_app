import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/profile/domain/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'].toString(),
            uid: uid,
            name: userData['name'],
            email: userData['email'],
          );
        }
        return null;
      }
    } catch (e) {
      return null;
    }

    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfie) async {
    try {
      await firebaseFirestore.collection('users').doc(updatedProfie.uid).update(
        {
          'bio': updatedProfie.bio,
          'profileImageUrl': updatedProfie.profileImageUrl,
        },
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
