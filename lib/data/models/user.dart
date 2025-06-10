import 'profile.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final Profile? profile;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role = 'user',
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        role: json['role'] ?? 'user',
        profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': role,
        if (profile != null) 'profile': profile!.toJson(),
      };
}

class UpdateUserRequest {
  final String firstName;
  final String lastName;
  final String email;

  UpdateUserRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
} 