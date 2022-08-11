import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:hour_calculator_flutter/HoursDB.dart';
import 'package:hour_calculator_flutter/HoursModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

String totalHours = "";

String inTimeTime = '';
String outTimeTime = '';

class _HomeTabState extends State<HomeTab> {

  final breakController = TextEditingController();

  late final SharedPreferences prefs;

  void loadTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('inTimeTime')) {
        inTimeTime = prefs.getString('inTimeTime').toString();
      }
      else {
        prefs.setString('inTimeTime', DateTime.now().toString());
        inTimeTime = DateTime.now().toString();
      }
      if (prefs.containsKey('outTimeTime')) {
        outTimeTime = prefs.getString('outTimeTime').toString();
      }
      else {
        prefs.setString('outTimeTime', DateTime.now().toString());
        outTimeTime = DateTime.now().toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadTime();
  }

  String inTimeHour = DateTime.now().hour.toString();
  String inTimeMinute = DateTime.now().minute.toString();
  String outTimeHour = DateTime.now().hour.toString();
  String outTimeMinute = DateTime.now().minute.toString();

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    DateTime lastTimeBackbuttonWasClicked = DateTime.now();
    return WillPopScope(onWillPop:() async {
      if (DateTime.now().difference(lastTimeBackbuttonWasClicked) >= Duration(seconds: 2)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Press the back button again to close the app"),
            duration: Duration(seconds: 2),
          ),
        );

        lastTimeBackbuttonWasClicked = DateTime.now();
        return false;
      }
      else {
        return true;
      }
    }, child:
      Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Hour Calculator'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('In Time'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TimePickerSpinner(
                itemHeight: 35,
                is24HourMode: false,
                normalTextStyle: const TextStyle(fontSize: 20),
                highlightedTextStyle: const TextStyle(fontSize: 24),
                isForce2Digits: true,
                time: inTimeTime == '' ? DateTime.now() : DateTime.parse(inTimeTime),
                minutesInterval: 1,
                onTimeChange: (time) {
                  _saveInTime(time.toString());
                  inTimeHour = time.hour.toString();
                  inTimeMinute = time.minute.toString();
                },
              ),
            ),
            const Text('Out Time'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TimePickerSpinner(
                itemHeight: 35,
                is24HourMode: false,
                normalTextStyle: const TextStyle(fontSize: 20),
                highlightedTextStyle: const TextStyle(fontSize: 24),
                isForce2Digits: true,
                time: outTimeTime == '' ? DateTime.now() : DateTime.parse(outTimeTime),
                minutesInterval: 1,
                onTimeChange: (time) {
                  saveOutTime(time.toString());
                  outTimeHour = time.hour.toString();
                  outTimeMinute = time.minute.toString();
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text('Break Time'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                maxLength: 2,
                controller: breakController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    breakController.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  }, icon: Icon(Icons.clear, color: Colors.teal,)
                  ,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: Colors.teal)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: Colors.teal)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: Colors.teal)),
                    labelText: '30',
                    labelStyle: TextStyle(color: Colors.teal),
                    counterText: ""),
                cursorColor: Colors.teal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    minimumSize: const Size.fromHeight(double.minPositive)),
                onPressed: () {
                  setState(() {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (inTimeMinute.length == 1) {
                      inTimeMinute = "0$inTimeMinute";
                    }
                    if (outTimeMinute.length == 1) {
                      outTimeMinute = "0$outTimeMinute";
                    }

                    String inTimeTotal = "";
                    String outTimeTotal = "";

                    double minutesDecimal = double.parse(
                        ((int.parse(outTimeMinute) - int.parse(inTimeMinute)) /
                            60.0)
                            .toString());
                    minutesDecimal =
                        double.parse(minutesDecimal.toStringAsFixed(2));

                    String minutesWithoutFirstDecimal =
                    minutesDecimal.toString().substring(2);
                    if (minutesDecimal < 0) {
                      minutesWithoutFirstDecimal =
                          (1.0 - double.parse(minutesWithoutFirstDecimal))
                              .toString();
                      minutesWithoutFirstDecimal =
                          double.parse(minutesWithoutFirstDecimal)
                              .toStringAsFixed(2);
                      minutesWithoutFirstDecimal =
                          minutesWithoutFirstDecimal.substring(2);
                    }

                    int hoursDifference =
                        int.parse(outTimeHour) - int.parse(inTimeHour);

                    if (double.parse(
                        "$hoursDifference.$minutesWithoutFirstDecimal") ==
                        0.0) {
                      totalHours = "In time and out time can not be the same";
                    } else {
                      if (minutesDecimal < 0) {
                        hoursDifference -= 1;
                      }
                      if (hoursDifference < 0) {
                        hoursDifference += 24;
                      }

                      if (int.parse(inTimeHour) > 12) {
                        int inTime = int.parse(inTimeHour) - 12;
                        String amOrPm = "PM";
                        inTimeTotal = "$inTime:$inTimeMinute $amOrPm";
                      } else if (int.parse(inTimeHour) == 12) {
                        int inTime = 12;
                        String amOrPm = "PM";
                        inTimeTotal = "$inTime:$inTimeMinute $amOrPm";
                      } else if (int.parse(inTimeHour) == 0) {
                        int inTime = 12;
                        String amOrPm = "AM";
                        inTimeTotal = "$inTime:$inTimeMinute $amOrPm";
                      } else {
                        String amOrPm = "AM";
                        inTimeTotal = "$inTimeHour:$inTimeMinute $amOrPm";
                      }

                      if (int.parse(outTimeHour) > 12) {
                        int outTime = int.parse(outTimeHour) - 12;
                        String amOrPm = "PM";
                        outTimeTotal = "$outTime:$outTimeMinute $amOrPm";
                      } else if (int.parse(outTimeHour) == 12) {
                        int outTime = 12;
                        String amOrPm = "PM";
                        outTimeTotal = "$outTime:$outTimeMinute $amOrPm";
                      } else if (int.parse(outTimeHour) > 12) {
                        int outTime = 12;
                        String amOrPm = "AM";
                        outTimeTotal = "$outTime:$outTimeMinute $amOrPm";
                      } else {
                        String amOrPm = "AM";
                        outTimeTotal = "$outTimeHour:$outTimeMinute $amOrPm";
                      }

                      double breakTimeNumber;
                      totalHours = "$hoursDifference.$minutesWithoutFirstDecimal";

                      if (breakController.text != null && breakController.text != "") {
                        if (!breakTimeNumeric(breakController.text)) {
                          totalHours = "Error with break time, must be numbers only";
                        }
                        else {
                          breakTimeNumber = double.parse(breakController.text) / 60;
                          String totalHoursWithBreak = (double.parse(totalHours) - breakTimeNumber).toStringAsFixed(2);

                          if (double.parse(totalHoursWithBreak) < 0.0) {
                            totalHours = "The entered break time is too big";
                          }
                          else {
                            savingHours(totalHours, inTimeTotal, outTimeTotal, breakController.text);

                            totalHours = "Total Hours: $hoursDifference.$minutesWithoutFirstDecimal\nTotal Hours Without Break: $totalHoursWithBreak";
                          }
                        }
                      }
                      else {
                        savingHours(totalHours, inTimeTotal, outTimeTotal, "0");
                        totalHours = "Total Hours: $hoursDifference.$minutesWithoutFirstDecimal";
                      }
                    }
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Calculate'),
                ),
              ),
            ),
            Text(totalHours, textAlign: TextAlign.center),
          ],
        )
      ) // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }

  void savingHours(String totalHours, String inTimeTotal, String outTimeTotal,
      String breakTime) {
    final hour = Hour(
      inTime: inTimeTotal,
      outTime: outTimeTotal,
      breakTime: breakTime,
      totalHours: totalHours,
      date: DateTime.now(),
    );

    HoursDatabase.instance.create(hour);
  }

  void _saveInTime(String inTime) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('inTimeTime');
      prefs.setString('inTimeTime', inTime);
      inTimeTime = inTime;
    });
  }

  Future saveOutTime(String outTime) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('outTimeTime');
      prefs.setString('outTimeTime', outTime);
      outTimeTime = outTime;
    });
  }

  bool breakTimeNumeric(String breakTime) {
    try {
      int.parse(breakTime);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
