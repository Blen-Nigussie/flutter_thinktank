import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/dashboard_screen.dart';
import 'screens/idea_submission_screen.dart';
import 'screens/ideas_screen.dart';
import 'screens/edit_idea_screen.dart';
import 'routes.dart';

class Navigation {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Screen.login: (context) => LoginPage(),
      Screen.register: (context) => RegisterPage(),
      Screen.home: (context) => DashboardScreen(),
      Screen.ideaSubmission: (context) => IdeaSubmissionScreen(),
      Screen.ideas: (context) => IdeasScreen(),
      Screen.editIdea: (context) => EditIdeaScreen(),
    };
  }

  static void navigateToIdeas(BuildContext context) {
    Navigator.pushReplacementNamed(context, Screen.ideas);
  }

  static void navigateToEditIdea(BuildContext context, String ideaId) {
    Navigator.pushNamed(context, '${Screen.editIdea}/$ideaId');
  }
} 