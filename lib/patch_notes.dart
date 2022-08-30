import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/home.dart';
import 'package:hour_calculator_flutter/main.dart';
import 'package:flutter/services.dart';
import 'config.dart' as globals;

AppModel appModel = globals.appModel;

class PatchNotes extends StatefulWidget {
  const PatchNotes({Key? key}) : super(key: key);

  @override
  _PatchNotesState createState() => _PatchNotesState();
}

var bugFixesArray = ['a', 'b', 'c', 'd', 'e'];
bool bugFixesVisible = false;

var newFeaturesArray = ['a', 'b', 'c', 'd', 'e'];
bool newFeaturesVisible = false;

var enhancementsArray = ['a', 'b', 'c', 'd', 'e'];
bool enhancementsVisible = false;

int accent = 0xFF009688;

class _PatchNotesState extends State<PatchNotes> {
  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                backgroundColor: Color(accent),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Patch Notes"),
                  background: Stack(fit: StackFit.expand, children: const [
                    DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blueGrey))
                  ]),
                )),
          ];
        },
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Text("Bug Fixes",
                      style: TextStyle(
                          color: Color(accent), fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Fixed issue with time pickers on home screen not remembering the previous time")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Fixed issue with it not storing the proper time if you had a break time entered")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Fixed issue with the status bar being the wrong color in theme management if you had light theme enabled")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Fixed issue with the status bar being the wrong color in the patch notes if you had light theme enabled")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Fixed with it showing the total hours backwards if you had a break time entered")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Fixed issue with status bar text not showing up properly depending on the theme of the phone and theme of the app")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Text("New Features",
                      style: TextStyle(
                          color: Color(accent), fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Added a badge in the bottom navigation bar to display how many items are stored in history")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text("Added a delete all button in history")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text("Added the ability to edit hours")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Text("Enhancements",
                      style: TextStyle(
                          color: Color(accent), fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Reworked the swipe to delete functionality in history")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Removed the \"Item Deleted\" toast message and replaced it with a snackbar with an \"Undo\" button")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Tweaked the design of the theme management section of the app")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text("Tweaked the design of the patch notes")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Tweaked the design of the app bars throughout the app")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "Tweaked the design of the list in the history view")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 15),
                  child: Card(
                    color: Color(accent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: ListTile(
                        title: Text(
                            "When leaving history tab and resuming, it will now remember scroll position")),
                  ),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
