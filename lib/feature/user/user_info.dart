import 'package:flutter/material.dart';
import 'package:github_issues_app/domain/user/user_entity.dart';

class UserInfo extends StatelessWidget {
  final User user;

  UserInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        SizedBox(height: 8.0),
        Text(
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            user.name),
        Text(style: const TextStyle(fontSize: 15), user.login),
        SizedBox(height: 8.0),
        Text(
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            user.bio),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                'Private repositories: '),
            Text(
                style: const TextStyle(
                  fontSize: 13,
                ),
                user.privateRepos.toString()),
            SizedBox(width: 16.0),
            Text(
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                'Public repositories: '),
            Text(
                style: const TextStyle(
                  fontSize: 13,
                ),
                user.publicRepos.toString()),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_pin),
            Text(
                style: const TextStyle(
                  fontSize: 13,
                ),
                user.location),
          ],
        ),
      ],
    );
  }
}
