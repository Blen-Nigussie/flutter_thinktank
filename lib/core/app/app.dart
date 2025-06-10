import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_theme_provider.dart';
import '../providers/app_localization_provider.dart';
import '../providers/app_navigation_provider.dart';
import '../providers/auth_view_model_provider.dart';
import 'app_initialization.dart';

class App extends ConsumerWidget {
  final AppInitialization initialization;

  const App(this.initialization, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final localization = ref.watch(appLocalizationProvider);
    final navigation = ref.watch(appNavigationProvider);
    final auth = ref.watch(authViewModelProvider);

    return MaterialApp(
      title: 'ThinkTank',
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      locale: localization.locale,
      navigatorKey: navigation.navigatorKey,
      initialRoute: auth.isAuthenticated ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => IdeaListScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
} 