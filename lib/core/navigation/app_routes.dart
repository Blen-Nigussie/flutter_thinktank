import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/idea_list_screen.dart';
import '../screens/idea_detail_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String ideaList = '/ideas';
  static const String ideaDetail = '/ideas/detail';
  static const String feedback = '/feedback';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes(AuthUiState authState) {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      ideaList: (context) => IdeaListScreen(),
      ideaDetail: (context) => IdeaDetailScreen(),
      feedback: (context) => FeedbackScreen(),
      profile: (context) => ProfileScreen(),
    };
  }

  static String getInitialRoute(AuthUiState authState) {
    return authState.user != null ? ideaList : login;
  }
} 