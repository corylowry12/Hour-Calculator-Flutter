import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:hour_calculator_flutter/HoursDB.dart';
import 'package:hour_calculator_flutter/HoursModel.dart';
import 'package:intl/intl.dart';
import 'config.dart' as globals;

class Edit extends StatefulWidget {
  late int id;
  late Hour hour;
  Edit(this.id, this.hour);
  @override
  State<StatefulWidget> createState() {
    return EditState(this.id, this.hour);
  }
}

int accent = 0xFF009688;

class EditState extends State<Edit> {
  late int id;
  late Hour hour;
  EditState(this.id, this.hour);

  bool isLoading = false;

  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();
    //getItem();
    getTheme();
  }

  getItem() async {
    hour = await HoursDatabase.instance.readHour(id);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    DateFormat dateFormatter = DateFormat('hh:mm a');

    //DateTime now = DateTime.now();
    //DateTime current = DateTime(now.year, now.month, now.day);
    //DateTime dateTime = DateTime.parse('$current 3:03 PM');

    final inTimeDate = dateFormatter.parse(hour.inTime);
    final outTimeDate = dateFormatter.parse(hour.outTime);

    String totalHours = '';

    DateTime inTimeTime = inTimeDate;
    DateTime outTimeTime = outTimeDate;

    String inTimeHour = inTimeDate.hour.toString();
    String inTimeMinute = inTimeDate.minute.toString();
    String outTimeHour = outTimeDate.hour.toString();
    String outTimeMinute = outTimeDate.minute.toString();
    final breakController = TextEditingController();
    breakController.text = hour.breakTime;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
            title: const Text(
                'Edit'),
            centerTitle: true,
            backgroundColor: Color(accent),
          ),
          body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                      'In Time'),
                  Padding(
                    padding: const EdgeInsets
                        .all(8.0),
                    child: TimePickerSpinner(
                      itemHeight: 35,
                      is24HourMode: false,
                      normalTextStyle: const TextStyle(
                          fontSize: 20),
                      highlightedTextStyle: const TextStyle(
                          fontSize: 24),
                      isForce2Digits: true,
                      time: inTimeTime,
                      minutesInterval: 1,
                      onTimeChange: (
                          time) {
                        inTimeHour =
                            time
                                .hour
                                .toString();
                        inTimeMinute =
                            time
                                .minute
                                .toString();
                      },
                    ),
                  ),
                  const Text(
                      'Out Time'),
                  Padding(
                    padding: const EdgeInsets
                        .all(8.0),
                    child: TimePickerSpinner(
                      itemHeight: 35,
                      is24HourMode: false,
                      normalTextStyle: const TextStyle(
                          fontSize: 20),
                      highlightedTextStyle: const TextStyle(
                          fontSize: 24),
                      isForce2Digits: true,
                      time: outTimeTime,
                      minutesInterval: 1,
                      onTimeChange: (
                          time) {
                        outTimeHour =
                            time
                                .hour
                                .toString();
                        outTimeMinute =
                            time
                                .minute
                                .toString();
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets
                        .only(
                        bottom: 4.0),
                    child: Text(
                        'Break Time'),
                  ),
                  Padding(
                    padding: const EdgeInsets
                        .only(
                        left: 10.0,
                        right: 10.0),
                    child: TextField(
                      autocorrect: false,
                      keyboardType: TextInputType
                          .number,
                      maxLength: 2,
                      controller: breakController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              breakController
                                  .clear();
                              FocusManager
                                  .instance
                                  .primaryFocus
                                  ?.unfocus();
                            },
                            icon: Icon(
                              Icons
                                  .clear,
                              color: Color(accent))
                            ,),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .circular(
                                  14.0),
                              borderSide: BorderSide(
                                  color: Color(accent))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .circular(
                                  14.0),
                              borderSide: BorderSide(
                                  color: Color(accent))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .circular(
                                  14.0),
                              borderSide: BorderSide(
                                  color: Color(accent))),
                          labelText: '30',
                          labelStyle: TextStyle(
                              color: Color(accent)),
                          counterText: ""),
                      cursorColor: Color(accent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets
                        .all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton
                          .styleFrom(
                          primary: Color(accent),
                          onPrimary: Colors
                              .white,
                          minimumSize: const Size
                              .fromHeight(
                              double
                                  .minPositive)),
                      onPressed: () {
                          FocusManager
                              .instance
                              .primaryFocus
                              ?.unfocus();

                          if (inTimeMinute
                              .length ==
                              1) {
                            inTimeMinute =
                            "0$inTimeMinute";
                          }
                          if (outTimeMinute
                              .length ==
                              1) {
                            outTimeMinute =
                            "0$outTimeMinute";
                          }

                          String inTimeTotal = "";
                          String outTimeTotal = "";

                          double minutesDecimal = double
                              .parse(
                              ((int
                                  .parse(
                                  outTimeMinute) -
                                  int
                                      .parse(
                                      inTimeMinute)) /
                                  60.0)
                                  .toString());
                          minutesDecimal =
                              double
                                  .parse(
                                  minutesDecimal
                                      .toStringAsFixed(
                                      2));

                          String minutesWithoutFirstDecimal =
                          minutesDecimal
                              .toString()
                              .substring(
                              2);
                          if (minutesDecimal <
                              0) {
                            minutesWithoutFirstDecimal =
                                (1.0 -
                                    double
                                        .parse(
                                        minutesWithoutFirstDecimal))
                                    .toString();
                            minutesWithoutFirstDecimal =
                                double
                                    .parse(
                                    minutesWithoutFirstDecimal)
                                    .toStringAsFixed(
                                    2);
                            minutesWithoutFirstDecimal =
                                minutesWithoutFirstDecimal
                                    .substring(
                                    2);
                          }

                          int hoursDifference =
                              int
                                  .parse(
                                  outTimeHour) -
                                  int
                                      .parse(
                                      inTimeHour);

                          if (double
                              .parse(
                              "$hoursDifference.$minutesWithoutFirstDecimal") ==
                              0.0) {
                            totalHours =
                            "In time and out time can not be the same";
                          } else {
                            if (minutesDecimal <
                                0) {
                              hoursDifference -=
                              1;
                            }
                            if (hoursDifference <
                                0) {
                              hoursDifference +=
                              24;
                            }

                            if (int
                                .parse(
                                inTimeHour) >
                                12) {
                              int inTime = int
                                  .parse(
                                  inTimeHour) -
                                  12;
                              String amOrPm = "PM";
                              inTimeTotal =
                              "$inTime:$inTimeMinute $amOrPm";
                            } else
                            if (int
                                .parse(
                                inTimeHour) ==
                                12) {
                              int inTime = 12;
                              String amOrPm = "PM";
                              inTimeTotal =
                              "$inTime:$inTimeMinute $amOrPm";
                            } else
                            if (int
                                .parse(
                                inTimeHour) ==
                                0) {
                              int inTime = 12;
                              String amOrPm = "AM";
                              inTimeTotal =
                              "$inTime:$inTimeMinute $amOrPm";
                            } else {
                              String amOrPm = "AM";
                              inTimeTotal =
                              "$inTimeHour:$inTimeMinute $amOrPm";
                            }

                            if (int
                                .parse(
                                outTimeHour) >
                                12) {
                              int outTime = int
                                  .parse(
                                  outTimeHour) -
                                  12;
                              String amOrPm = "PM";
                              outTimeTotal =
                              "$outTime:$outTimeMinute $amOrPm";
                            } else
                            if (int
                                .parse(
                                outTimeHour) ==
                                12) {
                              int outTime = 12;
                              String amOrPm = "PM";
                              outTimeTotal =
                              "$outTime:$outTimeMinute $amOrPm";
                            } else
                            if (int
                                .parse(
                                outTimeHour) >
                                12) {
                              int outTime = 12;
                              String amOrPm = "AM";
                              outTimeTotal =
                              "$outTime:$outTimeMinute $amOrPm";
                            } else {
                              String amOrPm = "AM";
                              outTimeTotal =
                              "$outTimeHour:$outTimeMinute $amOrPm";
                            }

                            double breakTimeNumber;
                            totalHours =
                            "$hoursDifference.$minutesWithoutFirstDecimal";

                            if (breakController
                                .text !=
                                "") {
                              if (!breakTimeNumeric(
                                  breakController
                                      .text)) {
                                totalHours =
                                "Error with break time, must be numbers only";
                              }
                              else {
                                breakTimeNumber =
                                    double
                                        .parse(
                                        breakController
                                            .text) /
                                        60;
                                String totalHoursWithBreak = (double
                                    .parse(
                                    totalHours) -
                                    breakTimeNumber)
                                    .toStringAsFixed(
                                    2);

                                if (double
                                    .parse(
                                    totalHoursWithBreak) <
                                    0.0) {
                                  totalHours =
                                  "The entered break time is too big";
                                }
                                else {
                                  savingHours(
                                      totalHoursWithBreak,
                                      inTimeTotal,
                                      outTimeTotal,
                                      breakController
                                          .text,
                                      hour
                                          .id!);

                                  totalHours = "Total Hours: $totalHoursWithBreak\nTotal Hours Without Break: $hoursDifference.$minutesWithoutFirstDecimal";
                                  Navigator.pop(context);
                                }
                              }
                            }
                            else {
                              savingHours(
                                  totalHours,
                                  inTimeTotal,
                                  outTimeTotal,
                                  "0",
                                  hour.id!);
                              totalHours =
                              "Total Hours: $hoursDifference.$minutesWithoutFirstDecimal";
                              Navigator.pop(context);
                            }
                          }
                        },
                      child: const Padding(
                        padding: EdgeInsets
                            .all(
                            8.0),
                        child: Text(
                            'Calculate'),
                      ),
                    ),
                  ),
                  Text(totalHours,
                      textAlign: TextAlign
                          .center,
                      style: const TextStyle(
                          fontSize: 16)),
                ],

          ),
        ),
      ),
    );
  }
  }

void savingHours(String totalHours, String inTimeTotal, String outTimeTotal,
    String breakTime, int itemID) {
  final hour = Hour(
    inTime: inTimeTotal,
    outTime: outTimeTotal,
    breakTime: breakTime,
    totalHours: totalHours,
    date: DateTime.now(),
  );
  HoursDatabase.instance.update(hour, itemID);
}

bool breakTimeNumeric(String breakTime) {
  try {
    int.parse(breakTime);
    return true;
  } on Exception catch (_) {
    return false;
  }
}