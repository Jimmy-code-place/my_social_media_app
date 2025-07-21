import 'package:social_media_app/features/auth/domain/entites/app_user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLouding extends AuthState {}

class Authintecated extends AuthState {
  final AppUser user;

  Authintecated({required this.user});
}

class UnAuthintecated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
