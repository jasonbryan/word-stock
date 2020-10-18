import 'package:flutter/material.dart';
import 'ad_manager.dart';
import 'package:firebase_admob/firebase_admob.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({Key key}) : super(key: key);

  @override
  _AdWidgetSate createState() => _AdWidgetSate();
}

class _AdWidgetSate extends State<AdWidget> {
  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  BannerAd _bannerAd;
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  @override
  void initState() {
    _initAdMob();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
