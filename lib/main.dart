import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/main_screen.dart';
import 'package:provider/provider.dart';
import 'config.dart' as globals;

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.teal,
        iconTheme: MaterialStateProperty.all<IconThemeData>(IconThemeData(
          color: Colors.black
        ))
      )
  );
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: Colors.black,
      primaryColor: Colors.teal,
      scaffoldBackgroundColor: Colors.black,
      useMaterial3: true);
}

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

AppModel appModel = globals.appModel;

class AppState extends State<App> {

  @override
  void initState() {
    super.initState();
    _initAppTheme();
  }

  void _initAppTheme() async {
    appModel.darkTheme = await appModel.appPreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>.value(
        value: appModel,
        child: Consumer<AppModel>(builder: (context, value, child) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'Hour Calculator',
            theme: appModel.darkTheme ? buildDarkTheme() : buildLightTheme(),
            home: const MainScreen(),
          );
        }));
  }
}

class ThemeManagement extends StatefulWidget {
  @override
  _ThemeManagement createState() => _ThemeManagement();
}

var groupID = appModel.darkTheme ? 1 : 0;

class _ThemeManagement extends State<ThemeManagement> {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
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
                  "Theme Management",
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
                child: Text("Background Theme",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text('Light Theme'),
                leading: Radio(
                  focusColor: Colors.teal,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.teal),
                  value: 0,
                  groupValue: groupID,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    appModel.darkTheme = false;
                    setState(() {
                      groupID = 0;
                    });
                  },
                ),
                onTap: () {
                  appModel.darkTheme = false;
                  setState(() {
                    groupID = 0;
                  });
                },
              ),
              ListTile(
                title: Text('Dark Theme'),
                leading: Radio(
                  focusColor: Colors.teal,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.teal),
                  value: 1,
                  groupValue: groupID,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    appModel.darkTheme = true;
                    groupID = 1;
                    setState(() {
                    });
                  },
                ),
                onTap: () {
                  appModel.darkTheme = true;
                  groupID = 1;
                  setState(() {
                  });
                },
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
