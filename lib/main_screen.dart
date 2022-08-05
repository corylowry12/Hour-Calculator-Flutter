import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/history.dart';
import 'package:hour_calculator_flutter/home.dart';
import 'package:hour_calculator_flutter/settings.dart';

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
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined, color: Colors.white),
                    selectedIcon: Icon(Icons.home, color: Colors.white),
                    label: 'Home'),
                NavigationDestination(icon: Icon(Icons.work_history_outlined, color: Colors.white),
                    selectedIcon: Icon(Icons.work_history, color: Colors.white),
                    label: 'History'),
                NavigationDestination(icon: Icon(Icons.settings_outlined, color: Colors.white),
                    selectedIcon: Icon(Icons.settings, color: Colors.white),
                    label: 'Settings')
              ],
          ),
        body: pages[currentIndex]
      );
    }
  }