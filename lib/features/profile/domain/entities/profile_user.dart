import 'package:social_media_app/features/auth/domain/entites/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  ProfileUser({
    required this.bio,
    required this.profileImageUrl,
    required super.uid,
    required super.name,
    required super.email,
  });

  ProfileUser copyWith({String? newBio, String? newProfileImageURl}) {
    return ProfileUser(
      bio: newBio ?? bio,
      profileImageUrl: newProfileImageURl ?? profileImageUrl,
      uid: uid,
      name: name,
      email: email,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory ProfileUser.fromJson(Map<String, dynamic> jsonUser) {
    return ProfileUser(
      uid: jsonUser['uid'],
      name: jsonUser['name'],
      email: jsonUser['email'],
      bio: jsonUser['bio'] ?? '',
      profileImageUrl: jsonUser['profileImageUrl'] ?? '',
    );
  }
}
