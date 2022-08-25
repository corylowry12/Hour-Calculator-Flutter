
import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:hour_calculator_flutter/AppPreference.dart';
import 'config.dart' as globals;

class AccentTheme extends StatefulWidget {
  @override
  _AccentThemeState createState() => _AccentThemeState();
}

late var groupID;
int accent = 0xFF009688;
late int customAccent;
late String customAccentText;

final Map<ColorSwatch<Object>, String> customSwatches =
<ColorSwatch<Object>, String>{
  const MaterialColor(0xFFfae738, <int, Color>{
    50: Color(0xFFfffee9),
    100: Color(0xFFfff9c6),
    200: Color(0xFFfff59f),
    300: Color(0xFFfff178),
    400: Color(0xFFfdec59),
    500: Color(0xFFfae738),
    600: Color(0xFFf3dd3d),
    700: Color(0xFFdfc735),
    800: Color(0xFFcbb02f),
    900: Color(0xFFab8923),
  }): 'Alpine',
  ColorTools.createPrimarySwatch(const Color(0xFFBC350F)): 'Rust',
  ColorTools.createAccentSwatch(const Color(0xFFB062DB)): 'Lavender',
};

class _AccentThemeState extends State<AccentTheme> {

  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    groupID = await AppPreference().getAccentThemeInt();
    customAccent = await AppPreference().getCustomAccentTheme();
    customAccentText = await AppPreference().getCustomAccentThemeText();
    setState(() {

    });
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
                backgroundColor: Color(accent),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                      fit: StackFit.expand,
                      children: [
                        DecoratedBox(decoration: BoxDecoration(color: Colors.blueGrey))
                      ]),
                  centerTitle: true,
                  title: Text(
                      "Accent Theme"),
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
                    child: Text("Accent Color",
                        style: TextStyle(
                            color: Color(accent), fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text('Teal (Default)'),
                      leading: Icon(Icons.format_paint_outlined, color: Colors.teal),
                      trailing: Radio(
                        focusColor: Color(accent),
                        fillColor:
                        MaterialStateColor.resolveWith((states) => Color(accent)),
                        value: 0,
                        groupValue: groupID,
                        activeColor: Colors.teal,
                        onChanged: (value) async {
                          groupID = 0;
                          globals.appPreference.setAccentThemePref(0);
                          accent = 0xFF009688;
                          globals.appPreference.setAccentThemeInt(0);

                          if (Platform.isIOS) {
                            try {
                              if (await FlutterDynamicIcon
                                  .supportsAlternateIcons) {
                                await FlutterDynamicIcon.setAlternateIconName(
                                    "teal_icon");
                                print("App icon change successful");
                                return;
                              }
                            } on PlatformException catch (_) {
                              if (kDebugMode) {
                                print("Failed to change app icon");
                              }
                            }
                          }
                          setState(() {

                          });
                        },
                      ),
                      onTap: () async {
                        groupID = 0;
                        globals.appPreference.setAccentThemePref(0);
                        accent = 0xFF009688;
                        globals.appPreference.setAccentThemeInt(0);

                        if (Platform.isIOS) {
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "teal_icon");
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException catch (_) {
                            if (kDebugMode) {
                              print("Failed to change app icon");
                            }
                          }
                        }
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text('Blue'),
                      leading: Icon(Icons.format_paint_outlined, color: Colors.blue),
                      trailing: Radio(
                        focusColor: Colors.teal,
                        fillColor:
                        MaterialStateColor.resolveWith((states) => Color(accent)),
                        value: 1,
                        groupValue: groupID,
                        activeColor: Colors.green,
                        onChanged: (value) async {
                          groupID = 1;
                          globals.appPreference.setAccentThemePref(1);
                          accent = 0xFF2196F3;
                          globals.appPreference.setAccentThemeInt(1);

                          if (Platform.isIOS) {
                            try {
                              if (await FlutterDynamicIcon
                                  .supportsAlternateIcons) {
                                await FlutterDynamicIcon.setAlternateIconName(
                                    "blue_icon");
                                print("App icon change successful");
                                return;
                              }
                            } on PlatformException catch (_) {
                              if (kDebugMode) {
                                print("Failed to change app icon");
                              }
                            }
                          }
                          setState(() {

                          });
                        },
                      ),
                      onTap: () async {
                        groupID = 1;
                        globals.appPreference.setAccentThemePref(1);
                        accent = 0xFF2196F3;
                        globals.appPreference.setAccentThemeInt(1);

                        if (Platform.isIOS) {
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "blue_icon");
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException catch (_) {
                            if (kDebugMode) {
                              print("Failed to change app icon");
                            }
                          }
                        }
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text('Orange'),
                      leading: Icon(Icons.format_paint_outlined, color: Colors.orange),
                      trailing: Radio(
                        focusColor: Colors.teal,
                        fillColor:
                        MaterialStateColor.resolveWith((states) => Color(accent)),
                        value: 2,
                        groupValue: groupID,
                        activeColor: Colors.green,
                        onChanged: (value) async {
                          groupID = 2;
                          globals.appPreference.setAccentThemePref(2);
                          accent = 0xFFFF9800;
                          globals.appPreference.setAccentThemeInt(2);

                          if (Platform.isIOS) {
                            try {
                              if (await FlutterDynamicIcon
                                  .supportsAlternateIcons) {
                                await FlutterDynamicIcon.setAlternateIconName(
                                    "orange_icon");
                                print("App icon change successful");
                                return;
                              }
                            } on PlatformException catch (_) {
                              if (kDebugMode) {
                                print("Failed to change app icon");
                              }
                            }
                          }
                          setState(() {

                          });
                        },
                      ),
                      onTap: () async {
                        groupID = 2;
                        globals.appPreference.setAccentThemePref(2);
                        accent = 0xFFFF9800;
                        globals.appPreference.setAccentThemeInt(2);

                        if (Platform.isIOS) {
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "orange_icon");
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException catch (_) {
                            if (kDebugMode) {
                              print("Failed to change app icon");
                            }
                          }
                        }
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text('Pink'),
                      leading: Icon(Icons.format_paint_outlined, color: Colors.pink),
                      trailing: Radio(
                        focusColor: Colors.teal,
                        fillColor:
                        MaterialStateColor.resolveWith((states) => Color(accent)),
                        value: 3,
                        groupValue: groupID,
                        activeColor: Colors.green,
                        onChanged: (value) async {
                          groupID = 3;
                          globals.appPreference.setAccentThemePref(3);
                          accent = 0xFFE91E63;
                          globals.appPreference.setAccentThemeInt(3);

                          if (Platform.isIOS) {
                            try {
                              if (await FlutterDynamicIcon
                                  .supportsAlternateIcons) {
                                await FlutterDynamicIcon.setAlternateIconName(
                                    "pink_icon");
                                print("App icon change successful");
                                return;
                              }
                            } on PlatformException catch (_) {
                              if (kDebugMode) {
                                print("Failed to change app icon");
                              }
                            }
                          }
                          setState(() {

                          });
                        },
                      ),
                      onTap: () async {
                        groupID = 3;
                        globals.appPreference.setAccentThemePref(3);
                        globals.appPreference.setAccentThemeInt(3);
                        accent = 0xFFE91E63;

                        if (Platform.isIOS) {
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "pink_icon");
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException catch (_) {
                            if (kDebugMode) {
                              print("Failed to change app icon");
                            }
                          }
                        }
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text('Red'),
                      leading: Icon(Icons.format_paint_outlined, color: Colors.red),
                      trailing: Radio(
                        focusColor: Colors.teal,
                        fillColor:
                        MaterialStateColor.resolveWith((states) => Color(accent)),
                        value: 4,
                        groupValue: groupID,
                        activeColor: Colors.green,
                        onChanged: (value) async {
                          groupID = 4;
                          globals.appPreference.setAccentThemePref(4);
                          accent = 0xFFF44336;
                          globals.appPreference.setAccentThemeInt(4);

                          if (Platform.isIOS) {
                            try {
                              if (await FlutterDynamicIcon
                                  .supportsAlternateIcons) {
                                await FlutterDynamicIcon.setAlternateIconName(
                                    "red_icon");
                                print("App icon change successful");
                                return;
                              }
                            } on PlatformException catch (_) {
                              if (kDebugMode) {
                                print("Failed to change app icon");
                              }
                            }
                          }
                          setState(() {

                          });
                        },
                      ),
                      onTap: () async {
                        groupID = 4;
                        globals.appPreference.setAccentThemePref(4);
                        globals.appPreference.setAccentThemeInt(4);
                        accent = 0xFFF44336;

                        if (Platform.isIOS) {
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "red_icon");
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException catch (_) {
                            if (kDebugMode) {
                              print("Failed to change app icon");
                            }
                          }
                        }
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text('Custom'),
                      subtitle: Text(customAccentText),
                      leading: Icon(Icons.format_paint_outlined, color: Color(customAccent)),
                      trailing: Radio(
                        focusColor: Colors.teal,
                        fillColor:
                        MaterialStateColor.resolveWith((states) => Color(accent)),
                        value: 5,
                        groupValue: groupID,
                        activeColor: Colors.green,
                        onChanged: (value) {

                        },
                      ),
                      onTap: () async {
                        final newColor = await showColorPickerDialog(
                          // The dialog needs a context, we pass it in.
                          context,
                          // We use the dialogSelectColor, as its starting color.
                          Colors.deepPurple,
                          title: Text('Custom Color',
                              style: Theme.of(context).textTheme.headline6),
                          width: 40,
                          height: 40,
                          spacing: 5,
                          runSpacing: 5,
                          borderRadius: 20,
                          wheelDiameter: 165,
                          enableOpacity: false,
                          barrierDismissible: false,
                          showColorCode: true,
                          colorCodeHasColor: true,
                          pickersEnabled: <ColorPickerType, bool>{
                            ColorPickerType.both: false,
                            ColorPickerType.primary: true,
                            ColorPickerType.accent: true,
                            ColorPickerType.bw: false,
                            ColorPickerType.custom: false,
                            ColorPickerType.wheel: true
                          },
                          hasBorder: true,
                          enableShadesSelection: true,
                          subheading: Text('Select color shade'),
                          enableTonalPalette: false,
                          heading: Text('Select Color', style: Theme.of(context).textTheme.headline6),
                          recentColorsSubheading: Text('Recently Used Colors'),
                          customColorSwatchesAndNames: customSwatches,
                          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                            copyButton: false,
                            pasteButton: false,
                            longPressMenu: false,
                          ),
                          actionButtons: const ColorPickerActionButtons(
                            okButton: true,
                            closeButton: true,
                            dialogActionButtons: false,
                          ),
                          constraints: const BoxConstraints(
                              minHeight: 480, minWidth: 320, maxWidth: 320),
                        );
                        groupID = 5;
                        globals.appPreference.setAccentThemePref(5);
                        globals.appPreference.setAccentThemeInt(5);
                        globals.appPreference.setCustomAccentThemePref(int.parse("0x${newColor.hexAlpha}"));
                        globals.appPreference.setCustomAccentThemePrefText("0x${newColor.hexAlpha}");
                        accent = int.parse("0x${newColor.hexAlpha}");
                        customAccent = int.parse("0x${newColor.hexAlpha}");
                        customAccentText = "0x${newColor.hexAlpha}";

                        if (Platform.isIOS) {
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "teal_icon");
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException catch (_) {
                            if (kDebugMode) {
                              print("Failed to change app icon");
                            }
                          }
                        }
                        setState(() {
                        });
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