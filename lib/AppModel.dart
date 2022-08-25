import 'package:flutter/material.dart';
import 'package:hour_calculator_flutter/AppPreference.dart';

class AppModel extends ChangeNotifier {

  AppPreference appPreference = AppPreference();
  int _darkTheme = 2;
  int get darkTheme => _darkTheme;

  int _accentTheme = 0xFF009688;
  int get accentTheme => _accentTheme;

  int _customAccentTheme = 0xFF009688;
  int get customAccentTheme => _customAccentTheme;

  set darkTheme(int value) {
    _darkTheme = value;
    appPreference.setThemePref(value);
    notifyListeners();
  }

  set accentTheme(int value) {
    _accentTheme = value;
    appPreference.setAccentThemePref(value);
    notifyListeners();
  }

  set customAccentTheme(int value) {
    _customAccentTheme = value;
    appPreference.setAccentThemePref(value);
    notifyListeners();
  }
}