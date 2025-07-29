import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLouding extends ProfileState {}

class ProfilLouded extends ProfileState {
  final ProfileUser profileUser;

  ProfilLouded({required this.profileUser});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
