import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/navigation_controller.dart';

final navigationControllerProvider = Provider<NavigationController>((ref) {
  return NavigationController();
}); 