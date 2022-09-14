library globals;
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/AppPreference.dart';
import 'BadgeModel.dart';
import 'HoursDB.dart';

AppModel appModel = AppModel();
BadgeModel badgeModel = BadgeModel();

HoursDatabase hoursDatabase = HoursDatabase.instance;

AppPreference appPreference = AppPreference();