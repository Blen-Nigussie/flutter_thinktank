import '../services/api_service.dart';
import '../network/network_info.dart';
import '../models/feedback.dart';

class FeedbackRepository {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;

  FeedbackRepository(this._apiService, this._networkInfo);

  Future<List<Feedback>> getFeedbacks() async {
    if (await _networkInfo.isConnected) {
      return await _apiService.getFeedbacks();
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<Feedback> getFeedbackById(String id) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.getFeedbackById(id);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<Feedback> createFeedback(String ideaId, String comment) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.createFeedback(ideaId, comment);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<Feedback> updateFeedback(String id, String comment) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.updateFeedback(id, comment);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<void> deleteFeedback(String id) async {
    if (await _networkInfo.isConnected) {
      await _apiService.deleteFeedback(id);
    } else {
      throw Exception('No internet connection');
    }
  }
} 