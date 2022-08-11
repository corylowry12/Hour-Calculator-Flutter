import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hour_calculator_flutter/HoursDB.dart';
import 'package:hour_calculator_flutter/HoursModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  List<Hour> hours = <Hour>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshHistory();
  }

  @override
  void dispose() {
    HoursDatabase.instance.close();

    super.dispose();
  }

  void refreshHistory() async {
    setState(() => isLoading = true);
    hours = await HoursDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: hours.isNotEmpty
          ? CustomScrollView(slivers: <Widget>[
              //2
              SliverAppBar(
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.teal,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "History",
                    style: TextStyle(color: ThemeColors().getTitleColors()),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                          decoration: BoxDecoration(color: ThemeColors().getTitleBarColors()))
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        var total = 0.0;
                        for (var i = 0; i < hours.length; i++) {
                          total += double.parse(hours[i].totalHours);
                        }
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  backgroundColor: const Color(0xffb2fdda),
                                  title: const Text("Info",
                                      style: TextStyle(color: Colors.black)),
                                  content: Text("Total Hours: ${total.toStringAsFixed(2)}\n"
                                                "Number of Entries: ${hours.length}",
                                      style: const TextStyle(color: Colors.black)),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK",
                                            style:
                                                TextStyle(color: Colors.teal)))
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.info)),
                  const SizedBox(width: 20),
                ],
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    final hour = hours[index];
                    final DateFormat formatter =
                        DateFormat('MMM/dd/yyyy hh:mm a');
                    final String formatted = formatter.format(hour.date);

                    return Dismissible(
                        key: Key(hour.id.toString()),
                        confirmDismiss: (direction) async {
                          return showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: const Color(0xffb2fdda),
                                title: const Text("Delete?",
                                    style: TextStyle(color: Colors.black)),
                                content: const Text("Would you like to delete this hour?",
                                    style: TextStyle(color: Colors.black)),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text("No",
                                          style:
                                          TextStyle(color: Colors.teal))),
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: const Text("Yes",
                                          style:
                                          TextStyle(color: Colors.teal)))
                                ],
                              ));
                        },
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          Fluttertoast.showToast(
                            msg: "Item Deleted",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          setState(() {
                            HoursDatabase.instance.delete(hour.id!);
                            hours.removeAt(index);
                          });
                        },
                        direction: DismissDirection.endToStart,
                        child: Card(
                            color: Colors.teal,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(28))),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('In Time: ${hour.inTime}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                            fontSize: 16)),
                                        Text('Out Time: ${hour.outTime}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                        Text('Break Time: ${hour.breakTime}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                        Text('Total: ${hour.totalHours}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                        Text('Date: $formatted',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.navigate_next,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            )));
                  },
                  childCount: hours.length,
                ),
              ),
            ])
          : CustomScrollView(slivers: <Widget>[
              //2
              SliverAppBar(
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.teal,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "History",
                    style: TextStyle(color: ThemeColors().getTitleColors()),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                          decoration: BoxDecoration(color: ThemeColors().getTitleBarColors()))
                    ],
                  ),
                ),
              ),
              const SliverFillRemaining(
                child: Center(
                  child: Text('No hours stored', style: TextStyle(fontSize: 16)),
                ),
              )

            ]
      )
  );
}
