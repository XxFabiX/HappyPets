import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/splash.dart';     
import 'pages/feedback.dart';   
// import 'pages/about.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final savedTheme = prefs.getString('app_theme') ?? 'light'; 

  runApp(MyApp(initialTheme: savedTheme));
}

class MyApp extends StatefulWidget {
  final String initialTheme;


  const MyApp({super.key, this.initialTheme = 'light'}); 

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
    String themeToApply = _currentTheme;

    if (_currentTheme == 'system') {
      themeToApply = 'light'; 
    }

    switch (themeToApply) {
      case 'dark':
        return ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.blue[700]!,
            secondary: Colors.lightBlueAccent[200]!,
            surface: Colors.grey[850]!,
            background: Colors.grey[900]!,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900], 
            elevation: 4,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          // ... puedes añadir más personalizaciones para el tema oscuro
        );
      case 'light':
      default: 
        return ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue[800]!,
            secondary: Colors.blueAccent[700]!,
            surface: Colors.white,
            background: Colors.grey[100]!, 
            onPrimary: Colors.white,
            onSecondary: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[800]!,
            elevation: 4,
            iconTheme: const IconThemeData(color: Colors.white), 
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          //personalizacion tema oscuro
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
