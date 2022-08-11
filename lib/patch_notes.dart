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

class _PatchNotesState extends State<PatchNotes> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
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
                  "Patch Notes",
                  style: TextStyle(color: ThemeColors().getTitleColors()),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                        decoration: BoxDecoration(
                            color: ThemeColors().getTitleBarColors()))
                  ],
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Bug Fixes",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                   child: ListTile(
                       title: Text("Fixed issue with the icons in the nav bar not being themed properly when dark theme was enabled",
                           style: TextStyle(color: ThemeColors().getTitleColors()))),
                  ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("New Features",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("No new features",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Enhancements",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("Added a dialog confirming deletion in the history tab",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("Redesigned the patch notes view",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("Made the text size for items in history slightly bigger",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("Added an \"Item Deleted\" pop up message when you delete an item",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("Put ads back in the app",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  color: Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(28))),
                  child: ListTile(
                      title: Text("The info dialog in history will now show the number of items",
                          style: TextStyle(color: ThemeColors().getTitleColors()))),
                ),
              ),
            ],
          ),
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
