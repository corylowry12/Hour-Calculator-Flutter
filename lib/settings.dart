import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/home.dart';
import 'package:hour_calculator_flutter/main.dart';
import 'package:flutter/services.dart';
import 'package:hour_calculator_flutter/patch_notes.dart';
import 'config.dart' as globals;

AppModel appModel = globals.appModel;

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  void initState() {
    appModel.appPreference.getTheme();
    setState(() {
    });
    super.initState();
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
              backgroundColor: Colors.teal,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Settings",
                  style: TextStyle(color: ThemeColors().getTitleColors()),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(decoration: BoxDecoration(color: ThemeColors().getTitleBarColors()))
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
                child: Text("Appearance",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(Icons.palette, color: ThemeColors().getColors()),
                title: Text("Theme Management",
                    style: TextStyle(color: ThemeColors().getTitleColors())),
                subtitle: Text("Customize the theme of the app",
                    style: TextStyle(color: ThemeColors().getSubtitleColors())),
                trailing: Icon(Icons.chevron_right, color: ThemeColors().getColors()),
                onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ThemeManagement())).then((value) {
                          setState(() {

                          });
                    });
                },
              ),
              Visibility(
                visible: false,
                child: ListTile(
                  leading: Icon(Icons.dashboard_customize, color: ThemeColors().getColors()),
                  title: Text("Home Screen Layout",
                      style: TextStyle(color: ThemeColors().getTitleColors())),
                  subtitle: Text("Customize the theme of the app",
                      style: TextStyle(color: ThemeColors().getSubtitleColors())),
                  trailing: Icon(Icons.chevron_right, color: ThemeColors().getColors()),
                  onTap: () {

                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Updates",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(Icons.update, color: ThemeColors().getColors()),
                title: Text("Patch Notes",
                    style: TextStyle(color: ThemeColors().getTitleColors())),
                subtitle: Text("View Changes in this update",
                    style: TextStyle(color: ThemeColors().getSubtitleColors())),
                trailing: Icon(Icons.chevron_right, color: ThemeColors().getColors()),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PatchNotes())).then((value) {
                    setState(() {

                    });
                  });
                },
              ),
              Visibility(
                visible: false,
                child: ListTile(
                  leading: Icon(Icons.settings_applications, color: ThemeColors().getColors()),
                  title: Text("Update Settings",
                      style: TextStyle(color: ThemeColors().getTitleColors())),
                  subtitle: Text("Customize settings affiliated with updates",
                      style: TextStyle(color: ThemeColors().getSubtitleColors())),
                  trailing: Icon(Icons.chevron_right, color: ThemeColors().getColors()),
                  onTap: () {
                  },
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
