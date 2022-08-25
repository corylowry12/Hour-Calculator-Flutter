import 'package:flutter/foundation.dart';
import 'package:hour_calculator_flutter/HoursDB.dart';
import 'package:hour_calculator_flutter/HoursModel.dart';

class BadgeModel extends ChangeNotifier {

  List<Hour> hours = <Hour>[];

  static String _information = "0";

  refreshHistory() async {
    hours = await HoursDatabase.instance.readAllNotes();
    _information = hours.length.toString();
  }

  get information {
    // Any aditional functionality
    return _information;
  }

  set setInformation (String value) {
    // Any additional functinality
    _information = value;
    notifyListeners();
  }

}