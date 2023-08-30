import 'package:github_issues_app/domain/repo/repo_entity.dart';
import 'package:github_issues_app/domain/user/user_entity.dart';
import 'package:tuple/tuple.dart';

abstract class AuthRepository {
  Future<Tuple3<String, User, List<Repo>>> getToken(String value);
  Future<void> saveToken(String token);
  Future<String?> readToken();
  Future<void> deleteToken();
}
