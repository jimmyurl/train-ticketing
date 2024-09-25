// utils/theme_helper.dart
import 'package:flutter/material.dart';

class ThemeHelper extends ChangeNotifier {
  String _themeMode;

  ThemeHelper(this._themeMode);

  String get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == 'light' ? 'dark' : 'light';
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData.light();
  ThemeData get darkTheme => ThemeData.dark();
}
