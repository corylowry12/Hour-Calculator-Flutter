import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/AdHelper.dart';
import 'package:hour_calculator_flutter/BadgeModel.dart';
import 'package:hour_calculator_flutter/HoursDB.dart';
import 'package:hour_calculator_flutter/HoursModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/config.dart';
import 'package:hour_calculator_flutter/history.dart';
import 'package:hour_calculator_flutter/home.dart';
import 'package:hour_calculator_flutter/settings.dart';
import 'package:provider/provider.dart';
import 'config.dart' as globals;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

BannerAd? _bannerAd;
int badgeNumber = 0;
BadgeModel badgeModel = globals.badgeModel;

late int accent;

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  getTheme() async {
    accent = await globals.appPreference.getAccentTheme();
    setState(() {});
  }

  @override
  void initState() {
    setOptimalDisplayMode();
    _initBadge();
    getTheme();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
  }

  void _initBadge() async {
    List<Hour> hours = <Hour>[];
    hours = await HoursDatabase.instance.readAllNotes();
    badgeModel.setInformation = hours.length.toString();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
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
    return ChangeNotifierProvider<BadgeModel>.value(
        value: badgeModel,
        child: Consumer<BadgeModel>(builder: (context, value, child) {
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
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home'),
                NavigationDestination(
                    icon: Badge(
                        animationType: BadgeAnimationType.fade,
                        badgeContent: Text(badgeModel.information,
                            style: TextStyle(fontSize: 10)),
                        child: Icon(Icons.work_history_outlined)),
                    selectedIcon: Badge(
                        animationType: BadgeAnimationType.fade,
                        badgeContent: Text(badgeModel.information,
                            style: TextStyle(fontSize: 10)),
                        child: Icon(Icons.work_history)),
                    label: 'History'),
                NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings')
              ],
            ),
            body: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: pages[currentIndex],
              ),
              if (_bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                )
            ]),
          );
        }));
  }
}
