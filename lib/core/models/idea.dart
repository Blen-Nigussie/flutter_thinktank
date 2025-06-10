import 'package:freezed_annotation/freezed_annotation.dart';

part 'idea.freezed.dart';
part 'idea.g.dart';

@freezed
class Idea with _$Idea {
  const factory Idea({
    required String id,
    required String title,
    required String description,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Idea;

  factory Idea.fromJson(Map<String, dynamic> json) => _$IdeaFromJson(json);
  
  @override
  DateTime get createdAt => throw UnimplementedError();
  
  @override
  String get description => throw UnimplementedError();

  @override
  String get id => throw UnimplementedError();

  @override
  String get title => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
  
  @override
  DateTime get updatedAt => throw UnimplementedError();
  
  @override
  String get userId => throw UnimplementedError();
} 