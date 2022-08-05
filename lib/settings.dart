import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  Future<void> setOptimalDisplayMode() async {
    await FlutterDisplayMode.setHighRefreshRate();
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
                title: const Text("Settings", style: TextStyle(
                  color: Colors.white
                ),),
                background: Stack(
                  fit: StackFit.expand,
                  children: const [
                    DecoratedBox(decoration: BoxDecoration(
                      color: Colors.black
                    ))
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0)),
                    color: Colors.teal,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          ListTile(
                            leading: Icon(Icons.palette, color: Colors.black),
                            title: Text("Appearance", style: TextStyle(color: Colors.black)),
                            subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                            trailing: Icon(Icons.chevron_right, color: Colors.black),
                          )
                        ],
                      ),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.palette, color: Colors.black),
                        title: Text("Appearance", style: TextStyle(color: Colors.black)),
                        subtitle: Text("Change Appearance Settings", style: TextStyle(color: Colors.white54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: Colors.teal,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SwitchListTile(value: false, onChanged: null,
                      title: Text('Title'),
                      subtitle: Text('Subtitle'),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
