class Profile {
  final String bio;
  final String avatarUrl;

  Profile({
    required this.bio,
    required this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        bio: json['bio'] ?? '',
        avatarUrl: json['avatarUrl'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'bio': bio,
        'avatarUrl': avatarUrl,
      };
}
 