class Idea {
  final String id;
  final String title;
  final String description;
  final String status;
  final List<String> tags;
  final String createdAt;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.tags,
    required this.createdAt,
  });

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      tags: List<String>.from(json['tags']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'tags': tags,
      'createdAt': createdAt,
    };
  }
} 