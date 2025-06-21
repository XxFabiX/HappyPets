import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _themeKey = 'app_theme'; // blanco oscuro y sistema
  static const String _showEmailKey = 'show_email';
  static const String _showPhoneKey = 'show_phone';

  Future<void> setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'system'; //defecto
  }

  //correo
Future<void> setShowEmail(bool show) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_showEmailKey, show);
}

Future<bool> getShowEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_showEmailKey) ?? true; 
}

//num contacto
Future<void> setShowPhone(bool show) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_showPhoneKey, show);
}

Future<bool> getShowPhone() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_showPhoneKey) ?? true; 
}
}