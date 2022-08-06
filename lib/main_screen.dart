import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/history.dart';
import 'package:hour_calculator_flutter/home.dart';
import 'package:hour_calculator_flutter/settings.dart';
import 'config.dart' as globals;

final AppModel appModel = globals.appModel;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  Future<void> setOptimalDisplayMode() async {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  List<Widget> pages = <Widget>[
    const HomeTab(),
    HistoryTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          // This trailing comma makes auto-formatting nicer for build methods.
          bottomNavigationBar: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              destinations: [
                NavigationDestination(icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home'),
                NavigationDestination(icon: Icon(Icons.work_history_outlined),
                    selectedIcon: Icon(Icons.work_history),
                    label: 'History'),
                NavigationDestination(icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings')
              ],
          ),
        body: pages[currentIndex]
      );
  }
}