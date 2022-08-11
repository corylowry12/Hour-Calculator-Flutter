import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4546055219731501/5171269817';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4546055219731501/2396708566';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}