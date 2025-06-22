import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/splash.dart';
import 'pages/feedback.dart';
import 'pages/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('app_theme') ?? 'system';
  
  runApp(MyApp(initialTheme: savedTheme));
}

class MyApp extends StatefulWidget {
  final String initialTheme;
  
  const MyApp({super.key, this.initialTheme = 'system'});

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  @override
  State<MyApp> createState() => MyAppState();
}


class MyAppState extends State<MyApp> {
  late String _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.initialTheme;
  }

  void changeTheme(String newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', newTheme);
    setState(() {
      _currentTheme = newTheme;
    });
  }

  ThemeData _getTheme() {
    switch (_currentTheme) {
      case 'dark':
        return ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.blue[800]!,
            secondary: Colors.blue[600]!,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.blue[900],
          ),
        );
      case 'light':
        return ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue[800]!,
            secondary: Colors.blue[600]!,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.blue[800],
          ),
        );
      default: // system
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        return brightness == Brightness.dark 
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue[800]!,
                secondary: Colors.blue[600]!,
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue[800]!,
                secondary: Colors.blue[600]!,
              ),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HappyPets',
      theme: _getTheme(),
      home: const SplashScreen(),
      routes: {
        '/feedback': (context) => const FeedbackPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
