import 'package:flutter/material.dart';
import 'pages/splash.dart';
import 'theme/app_theme.dart'; //tema personalizado

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final materialTheme = MaterialTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'HappyPets',
      theme: materialTheme.light(), //tema claro
      darkTheme: materialTheme.dark(), //tema oscuro
      home: const SplashScreen(),
    );
  }

}