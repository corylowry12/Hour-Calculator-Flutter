import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hour_calculator_flutter/HoursDB.dart';
import 'package:hour_calculator_flutter/HoursModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/config.dart';
import 'package:hour_calculator_flutter/edit.dart';
import 'config.dart' as globals;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

double scrollPosition = 0.0;

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

bool isVisible = false;

int hourCount = 0;
List<Hour> hours = <Hour>[];

int accent = 0xFF009688;

class _HistoryTabState extends State<HistoryTab> {

  bool isLoading = false;
  final _mainScrollController = ScrollController();

  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    isVisible = true;
    refreshHistory();
    getTheme();
    _mainScrollController.addListener(_onMainScroll);
  }

  void setScrollPosition() {
    _mainScrollController.jumpTo(100);
  }

  void _onMainScroll() {
    scrollPosition = _mainScrollController.position.pixels;
  }

  @override
  void dispose() {
    HoursDatabase.instance.close();
    _mainScrollController.dispose();
    super.dispose();
  }

  refreshHistory() async {
    setState(() => isLoading = true);
    hours = await HoursDatabase.instance.readAllNotes();
    hourCount = hours.length;
    setState(() => isLoading = false);
    _mainScrollController.jumpTo(scrollPosition);
  }

  @override
  Widget build(BuildContext context) => ScaffoldMessenger(
        child: Builder(
          builder: (context) => Scaffold(
              body: hours.isNotEmpty
                  ? Stack(children: [
                      CustomScrollView(
                        controller: _mainScrollController,
                        slivers: <Widget>[
                          SliverAppBar(
                            expandedHeight: 150.0,
                            floating: false,
                            pinned: true,
                            elevation: 0,
                            centerTitle: true,
                            backgroundColor: Color(accent),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    DecoratedBox(decoration: BoxDecoration(color: Colors.blueGrey))
                                  ]),
                              centerTitle: true,
                              title: Text(
                                "History"),
                              ),
                              /*background: Stack(
                                fit: StackFit.expand,
                                children: [
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: ThemeColors()
                                              .getTitleBarColors()))
                                ],
                              ),*/

                            actions: [
                              IconButton(
                                  onPressed: () {
                                    var total = 0.0;
                                    for (var i = 0; i < hours.length; i++) {
                                      total +=
                                          double.parse(hours[i].totalHours);
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              backgroundColor:
                                                  const Color(0xffb2fdda),
                                              title: const Text("Info",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              content: Text(
                                                  "Total Hours: ${total.toStringAsFixed(2)}\n"
                                                  "Number of Entries: ${hours.length}",
                                                  style: const TextStyle(
                                                      color: Colors.black)),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("OK",
                                                        style: TextStyle(
                                                            color:
                                                            Color(accent))))
                                              ],
                                            ));
                                  },
                                  icon: const Icon(Icons.info)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              backgroundColor:
                                                  const Color(0xffb2fdda),
                                              title: const Text("Delete All?",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              content: const Text(
                                                  "Would you like to delete all hours?",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No",
                                                        style: TextStyle(
                                                            color:
                                                            Color(accent)))),
                                                TextButton(
                                                    onPressed: () {
                                                      hourCount = 0;
                                                      badgeModel
                                                              .setInformation =
                                                          hourCount.toString();
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        HoursDatabase.instance
                                                            .deleteAll();
                                                        hours.clear();
                                                      });
                                                    },
                                                    child: Text("Yes",
                                                        style: TextStyle(
                                                            color:
                                                            Color(accent))))
                                              ],
                                            ));
                                  },
                                  icon: const Icon(Icons.delete)),
                              const SizedBox(width: 10),
                            ],
                          ),
                          SliverPadding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (_, int index) {
                                  final hour = hours[index];
                                  final DateFormat formatter =
                                      DateFormat('MMM/dd/yyyy hh:mm a');
                                  final String formatted =
                                      formatter.format(hour.date);

                                  return Slidable(
                                      key: UniqueKey(),
                                      startActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          dragDismissible: false,
                                          children: [
                                            SlidableAction(
                                              // An action can be bigger than the others.
                                              flex: 2,
                                              backgroundColor: Color(0xFFEB9E34),
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit_note_outlined,
                                              label: 'Edit',
                                              onPressed: ((context) async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Edit(hours[index].id!, hour),
                                                  ),
                                                ).then((value) => setState(() {
                                                  refreshHistory();
                                                }));
                                  }
                                              )
                                      )
                                      ]
                                          ),
                                      endActionPane: ActionPane(
                                          dismissible:
                                              DismissiblePane(onDismissed: () {
                                            hourCount = hours.length - 1;
                                            badgeModel.setInformation =
                                                hourCount.toString();
                                            setState(() {
                                              HoursDatabase.instance
                                                  .delete(hours[index].id!);
                                              hours.removeAt(index);
                                            });

                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text('Item Deleted'),
                                                duration: Duration(seconds: 5),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  textColor: Color(accent),
                                                  onPressed: () {
                                                    hours.insert(index, hour);
                                                    hourCount = hours.length;
                                                    badgeModel.setInformation =
                                                        hourCount.toString();
                                                    setState(() {});
                                                  },
                                                ),
                                              ));
                                          }),
                                          motion: ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              // An action can be bigger than the others.
                                              flex: 2,
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                              onPressed: ((context) {
                                                hourCount = hours.length - 1;
                                                badgeModel.setInformation =
                                                    hourCount.toString();
                                                setState(() {
                                                  HoursDatabase.instance
                                                      .delete(hours[index].id!);
                                                  hours.removeAt(index);
                                                });
                                                ScaffoldMessenger.of(context)
                                                  ..removeCurrentSnackBar()
                                                  ..showSnackBar(SnackBar(
                                                    behavior:
                                                        SnackBarBehavior.floating,
                                                    content: Text('Item Deleted'),
                                                    duration:
                                                        Duration(seconds: 5),
                                                    action: SnackBarAction(
                                                      label: 'Undo',
                                                      textColor: Color(accent),
                                                      onPressed: () {
                                                        hours.insert(index, hour);
                                                        hourCount = hours.length;
                                                        badgeModel
                                                                .setInformation =
                                                            hourCount.toString();
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ));
                                              }),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Edit(hours[index].id!, hour),
                                              ),
                                            ).then((value) => setState(() {
                                              refreshHistory();
                                            }));
                                          },
                                          child: Card(
                                                color: Color(accent),
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(28))),
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
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Text(
                                                                'In Time: ${hour.inTime}',
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16)),
                                                            Text(
                                                                'Out Time: ${hour.outTime}',
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16)),
                                                            Text(
                                                                'Break Time: ${hour.breakTime}',
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16)),
                                                            Text(
                                                                'Total: ${hour.totalHours}',
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
                                                )),
                                        ),
                                      ));
                                },
                                childCount: hours.length,
                              ),
                            ),
                          ),
                        ],
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
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            "History",
                          ),
                          /*background: Stack(
                            fit: StackFit.expand,
                            children: [
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: ThemeColors().getTitleBarColors()))
                            ],
                          ),*/
                        ),
                      ),
                      const SliverFillRemaining(
                        child: Center(
                          child: Text('No hours stored',
                              style: TextStyle(fontSize: 16)),
                        ),
                      )
                    ])),
        ),
      );
}
