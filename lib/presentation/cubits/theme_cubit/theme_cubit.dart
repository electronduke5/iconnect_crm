import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((_) {
  return throw UnimplementedError();
});

final appThemeProvider = ChangeNotifierProvider((ref) {
  return ThemeProvider(ref.watch(sharedPreferencesProvider));
});
class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._prefs);
  final SharedPreferences _prefs;

  void setThemeMode(ThemeMode themeMode){
    _prefs.setInt("theme", themeMode.index);
    notifyListeners();
  }

  ThemeMode getThemeMode() => _prefs.containsKey('theme') ? ThemeMode.values[_prefs.getInt('theme')!] : ThemeMode.system;
}