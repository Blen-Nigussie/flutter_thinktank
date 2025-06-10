import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_theme_provider.dart';
import '../providers/app_localization_provider.dart';
import '../providers/app_navigation_provider.dart';
import '/screens/login_screen.dart';
import '/screens/register_screen.dart';
import '/screens/idea_list_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/settings_screen.dart';
import '/screens/feedback_screen.dart';
import '/screens/home_page.dart';
import '/screens/about_page.dart';
import 'app_initialization.dart';

class App extends ConsumerWidget {
  const App(AppInitialization initialization, {super.key, required this.initialization});
  
  final AppInitialization initialization;
  dynamic apiService;
  dynamic appMainProvider;
  dynamic authViewModelProvider;


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
      initialRoute: auth.error == null ? '/home' : '/login',
      onGenerateRoute: (settings) {
        return navigation.onGenerateRoute(settings, auth);
      },
      onUnknownRoute: (settings) {
        return navigation.onUnknownRoute(settings, auth);
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localization.delegates,
      supportedLocales: localization.supportedLocales,
      localeListResolutionCallback: localization.localeListResolutionCallback,
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => IdeaListScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/': (context) => HomePage(title: 'Home', counter: 0),
        '/about': (context) => AboutPage(),
      },
    );
  }
}