import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  @override
  String get email => throw UnimplementedError('Email is not implemented in this context');

  @override
  String get id => throw UnimplementedError('ID is not implemented in this context');

  @override
  String get name => throw UnimplementedError('Name is not implemented in this context');

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
} 