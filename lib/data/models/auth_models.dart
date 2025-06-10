class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.role = 'user', // Default role is "user"
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role,
      };
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class LoginResponse {
  final String accessToken;

  LoginResponse({required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(accessToken: json['access_token']);
}

class AuthResponse {
  final String? accessToken;
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;

  AuthResponse({
    this.accessToken,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json['access_token'],
        id: json['id'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        role: json['role'],
      );
} 