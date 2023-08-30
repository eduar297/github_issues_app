import 'package:flutter/material.dart';
import 'package:github_issues_app/domain/repo/repo_entity.dart';

class RepoCard extends StatelessWidget {
  final Repo repo;

  RepoCard({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo.name ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                repo.description ?? '',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.circle, color: getColor(repo.language)),
                  SizedBox(width: 4),
                  Text(
                    repo.language ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Spacer(),
                  Icon(Icons.error_outline,
                      color:
                          repo.hasIssues ?? false ? Colors.red : Colors.green),
                  SizedBox(width: 4),
                  Text(
                    repo.hasIssues ?? false ? 'Has issues' : 'No issues',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(String? language) {
    switch (language) {
      case 'Dart':
        return Colors.blue;
      case 'JavaScript':
        return Colors.yellow;
      case 'Python':
        return Colors.green;
      case 'Java':
        return Colors.red;
      case 'C#':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
