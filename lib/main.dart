import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/config.dart';
import 'package:hour_calculator_flutter/main_screen.dart';
import 'package:provider/provider.dart';
import 'config.dart' as globals;
import 'package:adaptive_theme/adaptive_theme.dart';

int accent = 0xFF009688;

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: Color(accent),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Color(0xFFb0aeae),
        iconTheme: MaterialStateProperty.all<IconThemeData>(const IconThemeData(
          color: Colors.black
        ))
      ),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: Color(0xffadadad),
          contentTextStyle: TextStyle(
              color: Colors.black
          ),
          actionTextColor: Color(accent),
          shape: StadiumBorder()
      ),
   /* textTheme: TextTheme(
        headline1: TextStyle(),
        headline2: TextStyle(),
        headline3: TextStyle(),
        headline4: TextStyle(),
        headline5: TextStyle(),
        headline6: TextStyle(),
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        subtitle1: TextStyle(),
        subtitle2: TextStyle()
    ).apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),*/
      iconTheme: IconThemeData(color: Colors.black),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.black
    )
  );
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      useMaterial3: true,
      primaryColor: Color(accent),
      navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Color(0xFF787878),
      iconTheme: MaterialStateProperty.all<IconThemeData>(const IconThemeData(
          color: Colors.white
      ))
  ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xff5c5a5a),
      contentTextStyle: TextStyle(
        color: Colors.white
      ),
      actionTextColor: Color(accent),
        shape: StadiumBorder()
    ),
    /*textTheme: TextTheme(
        headline1: TextStyle(),
        headline2: TextStyle(),
        headline3: TextStyle(),
        headline4: TextStyle(),
        headline5: TextStyle(),
        headline6: TextStyle(),
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        subtitle1: TextStyle(),
        subtitle2: TextStyle()
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),*/
    iconTheme: IconThemeData(color: Colors.white)
  );
}

void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
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

  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _initAppTheme();
    getTheme();
  }

  late AdaptiveThemeMode savedThemeMode;

  void _initAppTheme() async {
    //appModel.darkTheme = await appModel.appPreference.getTheme();
    savedThemeMode = (await AdaptiveTheme.getThemeMode())!;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = window.platformDispatcher.platformBrightness;
    /*return ChangeNotifierProvider<AppModel>.value(
        value: appModel,
        child: Consumer<AppModel>(builder: (context, value, child) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'Hour Calculator',
            theme: appModel.darkTheme != 2 ? (appModel.darkTheme == 1 ? buildDarkTheme() : buildLightTheme()) : (isDarkTheme == Brightness.dark ? buildDarkTheme() : buildLightTheme()),
            home: const MainScreen(),
          );
        }));*/

    return AdaptiveTheme(
        light: buildLightTheme(),
        dark: buildDarkTheme(),
        initial: AdaptiveThemeMode.system,
        builder: (theme, darkTheme) =>
                      MaterialApp(
                        title: 'Hour Calculator',
                        theme: theme,
                        debugShowCheckedModeBanner: false,
                        darkTheme: darkTheme,
                        home: const MainScreen(),
                      )
    );
  }
}

class ThemeManagement extends StatefulWidget {
  @override
  _ThemeManagement createState() => _ThemeManagement();
}

late var groupID;
int colorAccent = 0xFF009688;

class _ThemeManagement extends State<ThemeManagement> {

  getTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    colorAccent = await globals.appPreference.getAccentTheme();
    if (savedThemeMode == AdaptiveThemeMode.light) {
      groupID = 0;
      setState(() {

      });
    }
    else if (savedThemeMode == AdaptiveThemeMode.dark) {
      groupID = 1;
      setState(() {

      });
    }
    else {
      groupID = 2;
      setState(() {

      });
    }
  }
  @override
  void initState() {
    getTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //final appModel = Provider.of<AppModel>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Color(colorAccent),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                        fit: StackFit.expand,
                        children: [
                          DecoratedBox(decoration: BoxDecoration(color: Colors.blueGrey))
                        ]),
                    centerTitle: true,
                    title: Text(
                        "Dark Mode"),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Automatic",
                          style: TextStyle(
                              color: Color(colorAccent), fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: ListTile(
                        title: Text('Follow System'),
                        leading: Icon(Icons.brightness_6_outlined),
                        trailing: Radio(
                          focusColor: Color(colorAccent),
                          fillColor:
                          MaterialStateColor.resolveWith((states) => Color(colorAccent)),
                          value: 2,
                          groupValue: groupID,
                          activeColor: Color(colorAccent),
                          onChanged: (value) {
                            /* appModel.darkTheme = 2;
                          groupID = 2;
                          setState(() {
                          });*/
                            AdaptiveTheme.of(context).setSystem();
                            groupID = 2;
                            setState(() {

                            });
                          },
                        ),
                        onTap: () {
                          /* appModel.darkTheme = 2;
                          groupID = 2;
                          setState(() {
                          });*/
                          AdaptiveTheme.of(context).setSystem();
                          groupID = 2;
                          setState(() {

                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text("Manual",
                          style: TextStyle(
                              color: Color(colorAccent), fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: ListTile(
                        title: Text('Light Theme'),
                        leading: Icon(Icons.brightness_7_outlined),
                        trailing: Radio(
                          focusColor: Color(colorAccent),
                          fillColor:
                          MaterialStateColor.resolveWith((states) => Color(colorAccent)),
                          value: 0,
                          groupValue: groupID,
                          activeColor: Color(colorAccent),
                          onChanged: (value) {
                            /*appModel.darkTheme = 0;
                            setState(() {
                              groupID = 0;
                            });*/
                            AdaptiveTheme.of(context).setLight();
                            groupID = 0;
                          },
                        ),
                        onTap: () {
                          /*appModel.darkTheme = 0;
                            setState(() {
                              groupID = 0;
                            });*/
                          AdaptiveTheme.of(context).setLight();
                          groupID = 0;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: ListTile(
                        title: Text('Dark Theme'),
                        leading: Icon(Icons.dark_mode_outlined),
                        trailing: Radio(
                          focusColor: Color(colorAccent),
                          fillColor:
                          MaterialStateColor.resolveWith((states) => Color(colorAccent)),
                          value: 1,
                          groupValue: groupID,
                          activeColor: Color(colorAccent),
                          onChanged: (value) {
                            /* appModel.darkTheme = 1;
                          groupID = 1;
                          setState(() {
                          });*/
                            AdaptiveTheme.of(context).setDark();
                            groupID = 1;
                          },
                        ),
                        onTap: () {
                         /* appModel.darkTheme = 1;
                          groupID = 1;
                          setState(() {
                          });*/
                          AdaptiveTheme.of(context).setDark();
                          groupID = 1;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
        ),
    );
  }
}
