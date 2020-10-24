import 'package:firebase_admob/firebase_admob.dart';
import 'package:word_stock/services/ad_manager.dart';
import 'package:word_stock/services/word_service.dart';
import 'package:flutter/material.dart';
import 'widgets/points/points_widget.dart';
import 'widgets/points/streak_widget.dart';
import 'widgets/word/word.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Stats> _getStats = getStats();
  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  BannerAd _bannerAd;
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(
        anchorOffset: 60.0,
        horizontalCenterOffset: 10.0,
        anchorType: AnchorType.bottom,
      );
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
    return FutureBuilder(
      future: _getStats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                WordWidget(stats: snapshot.data),
                PointsWidget(stats: snapshot.data),
                StreakWidget(stats: snapshot.data),
              ],
            ),
          );
        }
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}
