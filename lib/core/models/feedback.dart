import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback.freezed.dart';
part 'feedback.g.dart';

@freezed
abstract class Feedback with _$Feedback {
  const factory Feedback({
    required String id,
    required String ideaId,
    required String userId,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Feedback;

  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);
} 