import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/repo/profile_repo.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLouding());
      final user = await profileRepo.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfilLouded(profileUser: user));
      } else {
        emit(ProfileError(message: 'user not found'));
      }
    } catch (e) {
      emit(ProfileError(message: 'user not found'));
    }
  }

  Future<void> updateUserProfile({
    required String uid,
    required String? newBio,
  }) async {
    emit(ProfileLouding());
    try {
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError(message: 'failed to fetch user profile'));
        return;
      }
      final updatedUser = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
      );

      await profileRepo.updateProfile(updatedUser);

      await profileRepo.fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError(message: 'error updating profile..  $e'));
    }
  }
}
