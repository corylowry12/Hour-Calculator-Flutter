import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference extends ChangeNotifier {
  static const DARK_THEME_SETTING = "DARKTHEMESETTING";
  static const ACCENT_THEME_SETTING = "ACCENTTHEMESETTING";
  static const ACCENT_THEME_INT = "ACCENTTHEMEINT";
  static const CUSTOM_ACCENT_THEME_SETTING = "CUSTOMACCENTTHEMESETTING";
  static const CUSTOM_ACCENT_THEME_SETTING_TEXT =
      "CUSTOMACCENTTHEMESETTINGTEXT";
  static const DIALOG_BACKGROUND_THEME_SETTING = "DIALOGBACKGROUNDTHEMESETTING";
  static const DIALOG_BUTTON_THEME_SETTING = "DIALOGBUTTONTHEMESETTING";

  setThemePref(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(DARK_THEME_SETTING, value);
  }

  Future<int> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(DARK_THEME_SETTING)!;
  }

  setAccentThemePref(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(ACCENT_THEME_SETTING, value);
  }

  setAccentThemeInt(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(ACCENT_THEME_INT, value);
  }

  Future<int> getAccentThemeInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(ACCENT_THEME_INT) ?? 0;
  }

  Future<int> getAccentTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(ACCENT_THEME_SETTING) == 0) {
      return 0xFF009688;
    } else if (prefs.getInt(ACCENT_THEME_SETTING) == 1) {
      return 0xFF2196F3;
    } else if (prefs.getInt(ACCENT_THEME_SETTING) == 2) {
      return 0xFFFF9800;
    } else if (prefs.getInt(ACCENT_THEME_SETTING) == 3) {
      return 0xFFE91E63;
    } else if (prefs.getInt(ACCENT_THEME_SETTING) == 4) {
      return 0xFFF44336;
    } else if (prefs.getInt(ACCENT_THEME_SETTING) == 5) {
      return prefs.getInt(CUSTOM_ACCENT_THEME_SETTING)!;
    }
    return 0xFF009688;
  }

  setCustomAccentThemePref(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(CUSTOM_ACCENT_THEME_SETTING, value);
  }

  Future<int> getCustomAccentTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(CUSTOM_ACCENT_THEME_SETTING) ?? 0xFF009688;
  }

  setCustomAccentThemePrefText(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CUSTOM_ACCENT_THEME_SETTING_TEXT, value);
  }

  Future<String> getCustomAccentThemeText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CUSTOM_ACCENT_THEME_SETTING_TEXT) ?? "0xFF009688";
  }

  setDialogButtonColor(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DIALOG_BUTTON_THEME_SETTING, value);
  }

  Future<String> getDialogButtonColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DIALOG_BUTTON_THEME_SETTING) ?? "0xFF00786C";
  }

  setDialogBackgroundColor(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DIALOG_BACKGROUND_THEME_SETTING, value);
  }

  Future<String> getDialogBackgroundColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DIALOG_BACKGROUND_THEME_SETTING) ?? "0xFF009688";
  }
}
