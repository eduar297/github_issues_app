class User {
  final int id;
  final String login;
  final String name;
  final String avatarUrl;
  final String bio;
  final String location;
  final publicRepos;
  final privateRepos;

  User({
    required this.id,
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required this.location,
    required this.publicRepos,
    required this.privateRepos,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        login: json['login'],
        name: json['name'],
        avatarUrl: json['avatar_url'],
        bio: json['bio'],
        location: json['location'],
        publicRepos: json['public_repos'],
        privateRepos: json['total_private_repos']);
  }
}
