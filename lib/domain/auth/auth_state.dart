import 'package:github_issues_app/domain/repo/repo_entity.dart';
import 'package:github_issues_app/domain/user/user_entity.dart';

abstract class AuthState {}

class Initial extends AuthState {}

class Loading extends AuthState {}

class Authenticated extends AuthState {
  final String token;
  final User user;
  final List<Repo> repos;

  Authenticated(this.token, this.user, this.repos);
}

class Unauthenticated extends AuthState {}
