import 'package:flutter/material.dart';
import 'navigation_controller.dart';
import 'app_routes.dart';
import '../auth/auth_ui_state.dart';

class AppNavigation {
  final NavigationController navigationController;
  final AppRoutes appRoutes;

  AppNavigation(this.navigationController, this.appRoutes);

  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return navigationController.navigateTo(routeName, arguments: arguments);
  }

  Future<T?> navigateToReplacement<T>(String routeName, {Object? arguments}) {
    return navigationController.navigateToReplacement(routeName, arguments: arguments);
  }

  Future<T?> navigateToAndClearStack<T>(String routeName, {Object? arguments}) {
    return navigationController.navigateToAndClearStack(routeName, arguments: arguments);
  }

  void goBack<T>([T? result]) {
    navigationController.goBack(result);
  }

  Map<String, WidgetBuilder> getRoutes(AuthUiState authState) {
    return AppRoutes.getRoutes(authState);
  }

  String getInitialRoute(AuthUiState authState) {
    return AppRoutes.getInitialRoute(authState);
  }
} 