import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/feedback_repository.dart';
import 'api_service_provider.dart';
import 'network_info_provider.dart';

final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return FeedbackRepository(apiService, networkInfo);
});