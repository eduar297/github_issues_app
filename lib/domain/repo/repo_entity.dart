class Repo {
  final int? id;
  final String? type;
  final String? name;
  final String? htmlUrl;
  final String? description;
  final String? language;
  final bool? hasIssues;
  final String? visibility;

  Repo({
    required this.id,
    required this.type,
    required this.name,
    required this.htmlUrl,
    required this.description,
    required this.language,
    required this.hasIssues,
    required this.visibility,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
        id: json['id'] ?? 0,
        type: json['type'] ?? '',
        name: json['name'] ?? '',
        htmlUrl: json['html_url'] ?? '',
        description: json['description'] ?? '',
        language: json['language'] ?? '',
        hasIssues: json['has_issues'] ?? false,
        visibility: json['visibility'] ?? '');
  }
}
