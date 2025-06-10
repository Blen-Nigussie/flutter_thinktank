// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Feedback _$FeedbackFromJson(Map<String, dynamic> json) => _Feedback(
      id: json['id'] as String,
      ideaId: json['ideaId'] as String,
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FeedbackToJson(_Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'ideaId': instance.ideaId,
      'userId': instance.userId,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
