class Idea {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      authorId: json['authorId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 