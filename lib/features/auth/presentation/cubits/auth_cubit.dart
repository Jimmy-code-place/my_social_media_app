import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/features/auth/domain/entites/app_user.dart';
import 'package:social_media_app/features/auth/domain/repos/auth_repo.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentuser;
  AuthCubit(this.authRepo) : super(AuthInitial());

  void authCheck() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentuser = user;
      emit(Authintecated(user: user));
    } else {
      emit(UnAuthintecated());
    }
  }

  AppUser? get currentuser => _currentuser;

  Future<void> loginWithEmailAndPw(String email, String pw) async {
    try {
      emit(AuthLouding());
      final user = await authRepo.logInWithEmailPassword(email, pw);
      if (user != null) {
        _currentuser = user;
        emit(Authintecated(user: user));
      } else {
        emit(UnAuthintecated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(UnAuthintecated());
    }
  }

  Future<void> register(String name, String email, String pw) async {
    try {
      emit(AuthLouding());
      final user = await authRepo.registerWithEmailPassword(name, email, pw);
      if (user != null) {
        _currentuser = user;
        emit(Authintecated(user: user));
      } else {
        emit(UnAuthintecated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(UnAuthintecated());
    }
  }

  Future<void> logOut() async {
    authRepo.logOut();
    emit(UnAuthintecated());
  }
}
