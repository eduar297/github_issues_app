import 'package:flutter/material.dart';
import 'package:github_issues_app/domain/repo/repo_entity.dart';
import 'package:github_issues_app/feature/repo/repo_card.dart';

class RepositoriesList extends StatelessWidget {
  final List<Repo> repos;

  RepositoriesList({required this.repos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            'Repositories'),
        SizedBox(
          width: 800,
          height: 600,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  return RepoCard(repo: repos[index]);
                },
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
