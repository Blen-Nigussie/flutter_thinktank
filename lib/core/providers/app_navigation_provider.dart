import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinktank/core/viewmodels/auth_view_model.dart';
import 'package:thinktank/screens/feedback_screen.dart';
import 'package:thinktank/screens/idea_list_screen.dart';
import 'package:thinktank/screens/login_screen.dart';
import 'package:thinktank/screens/profile_screen.dart';
import 'package:thinktank/screens/register_screen.dart';

final appNavigationProvider = Provider<AppNavigation>((ref) {
  return AppNavigation();
});

class AppNavigation {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic>? onGenerateRoute(RouteSettings settings, AuthViewModel auth) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => IdeaListScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => FeedbackScreen());
      default:
        return null; // Handle unknown routes
    }
  }

  Route<dynamic>? onUnknownRoute(RouteSettings settings, AuthViewModel auth) {
    // Handle unknown routes, e.g., redirect to login if not authenticated
    if (auth.user == null) {
      return MaterialPageRoute(builder: (_) => LoginScreen());
    } else {
      return MaterialPageRoute(builder: (_) => IdeaListScreen());
    }
  }
}