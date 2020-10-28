import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5316667459256484~9312064451";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5316667459256484~5728128381";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5316667459256484/3601229319";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5316667459256484/1911300166";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
