import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/token_manager.dart';

final tokenManagerProvider = Provider<TokenManager>((ref) {
  return TokenManager();
}); 