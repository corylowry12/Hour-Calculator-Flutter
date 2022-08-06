import 'package:flutter/material.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'config.dart' as globals;

AppModel appModel = globals.appModel;

class ThemeColors {

  Color getColors() {
    if (!appModel.darkTheme) {
      return Colors.black;
    }
    else {
      return Colors.white;
    }
  }

  Color getTitleBarColors() {
    if (appModel.darkTheme) {
      return Colors.black;
    }
    else {
      return Colors.white;
    }
  }

  Color getTitleColors() {
    if (appModel.darkTheme) {
      return Colors.white;
    }
    else {
      return Colors.black;
    }
  }

  Color getSubtitleColors() {
    if (appModel.darkTheme) {
      return Colors.white54;
    }
    else {
      return Colors.grey;
    }
  }

}