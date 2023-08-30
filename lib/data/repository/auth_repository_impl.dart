import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_issues_app/domain/repo/repo_entity.dart';
import 'package:http/http.dart' as http;
import 'package:github_issues_app/domain/auth/auth_repository.dart';
import 'package:github_issues_app/domain/user/user_entity.dart';
import 'package:tuple/tuple.dart';

class AuthRepositoryImpl implements AuthRepository {
  final storage = FlutterSecureStorage();
  final client = http.Client();

  Future<User> _getUser(String token) async {
    final response = await client.get(
      Uri.parse('https://api.github.com/user'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<List<Repo>> _getRepos(String token) async {
    final response = await client.get(
      Uri.parse('https://api.github.com/user/repos'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final repos = data.map((e) => Repo.fromJson(e)).toList();
      return repos;
    } else {
      throw Exception('Failed to get repos');
    }
  }

  @override
  Future<Tuple3<String, User, List<Repo>>> getToken(String value) async {
    final user = await _getUser(value);
    final repos = await _getRepos(value);
    return Tuple3(value, user, repos);
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> readToken() async {
    return await storage.read(key: 'token');
  }

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
