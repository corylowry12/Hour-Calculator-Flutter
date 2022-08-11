import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hour_calculator_flutter/AdHelper.dart';
import 'package:hour_calculator_flutter/AppModel.dart';
import 'package:hour_calculator_flutter/ThemeColors.dart';
import 'package:hour_calculator_flutter/history.dart';
import 'package:hour_calculator_flutter/home.dart';
import 'package:hour_calculator_flutter/settings.dart';
import 'config.dart' as globals;
import 'package:google_mobile_ads/google_mobile_ads.dart';

final AppModel appModel = globals.appModel;

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

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    setOptimalDisplayMode();

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
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.work_history_outlined),
              selectedIcon: Icon(Icons.work_history),
              label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings')
        ],
      ),
      body: SafeArea(
          child: Stack(children: [
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
      ])),
    );
  }
}
