import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/accent_theme.dart';
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

int accent = 0xFF009688;

class _SettingsTabState extends State<SettingsTab> {

  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    setState(() {

    });
  }

  @override
  void initState() {
    getTheme();
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
              backgroundColor: Color(accent),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(decoration: BoxDecoration(color: Colors.blueGrey))
                    ]),
                centerTitle: true,
                title: Text(
                  "Settings"),
                ),
              ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text("Appearance",
                    style: TextStyle(
                        color: Color(accent), fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(Icons.dark_mode_outlined),
                title: Text("Dark Mode"),
                subtitle: Text("Choose dark, light or follow system"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThemeManagement())).then((value) {
                    setState(() {

                    });
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.palette_outlined),
                title: Text("Accent Color"),
                subtitle: Text("Choose from multiple different accent colors"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccentTheme())).then((value) {
                    setState(() {
                      getTheme();
                    });
                  });
                },
              ),
              Visibility(
                visible: false,
                child: ListTile(
                  leading: Icon(Icons.dashboard_customize),
                  title: Text("Home Screen Layout"),
                  subtitle: Text("Customize the theme of the app"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text("Updates",
                    style: TextStyle(
                        color: Color(accent), fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(Icons.update),
                title: Text("Patch Notes"),
                subtitle: Text("View Changes in this update"),
                trailing: Icon(Icons.chevron_right),
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
                  leading: Icon(Icons.settings_applications),
                  title: Text("Update Settings"),
                  subtitle: Text("Customize settings affiliated with updates"),
                  trailing: Icon(Icons.chevron_right),
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