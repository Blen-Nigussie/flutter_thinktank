import 'idea.dart';
import 'user.dart';

enum FeedbackStatus {
  reviewed,
  approved,
  rejected;

  static FeedbackStatus fromString(String value) {
    switch (value) {
      case 'Reviewed':
        return FeedbackStatus.reviewed;
      case 'Approved':
        return FeedbackStatus.approved;
      case 'Rejected':
        return FeedbackStatus.rejected;
      default:
        return FeedbackStatus.reviewed;
    }
  }

  String toString() {
    switch (this) {
      case FeedbackStatus.reviewed:
        return 'Reviewed';
      case FeedbackStatus.approved:
        return 'Approved';
      case FeedbackStatus.rejected:
        return 'Rejected';
    }
  }
}

class Feedback {
  final int id;
  final String comment;
  final User admin;
  final Idea idea;
  final FeedbackStatus status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  Feedback({
    required this.id,
    required this.comment,
    required this.admin,
    required this.idea,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json['id'],
        comment: json['comment'],
        admin: User.fromJson(json['admin']),
        idea: Idea.fromJson(json['idea']),
        status: FeedbackStatus.fromString(json['status']),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
      );
}

class CreateFeedbackRequest {
  final int ideaId;
  final String comment;
  final FeedbackStatus status;

  CreateFeedbackRequest({
    required this.ideaId,
    required this.comment,
    this.status = FeedbackStatus.reviewed,
  });

  Map<String, dynamic> toJson() => {
        'ideaId': ideaId,
        'comment': comment,
        'status': status.toString(),
      };
}

class UpdateFeedbackRequest {
  final String? comment;
  final FeedbackStatus? status;

  UpdateFeedbackRequest({
    this.comment,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        if (comment != null) 'comment': comment,
        if (status != null) 'status': status.toString(),
      };
} 