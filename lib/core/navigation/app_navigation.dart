import 'package:flutter/material.dart';
import 'navigation_controller.dart';
import 'app_routes.dart';

class AppNavigation {
  final NavigationController _navigationController;
  final AppRoutes _appRoutes;

  AppNavigation(this._navigationController, this._appRoutes);

  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return _navigationController.navigateTo(routeName, arguments: arguments);
  }

  Future<T?> navigateToReplacement<T>(String routeName, {Object? arguments}) {
    return _navigationController.navigateToReplacement(routeName, arguments: arguments);
  }

  Future<T?> navigateToAndClearStack<T>(String routeName, {Object? arguments}) {
    return _navigationController.navigateToAndClearStack(routeName, arguments: arguments);
  }

  void goBack<T>([T? result]) {
    _navigationController.goBack(result);
  }

  Map<String, WidgetBuilder> getRoutes(AuthUiState authState) {
    return _appRoutes.getRoutes(authState);
  }

  String getInitialRoute(AuthUiState authState) {
    return _appRoutes.getInitialRoute(authState);
  }
} 