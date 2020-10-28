import 'package:firebase_admob/firebase_admob.dart';
import 'package:word_stock/ad/ad_widget.dart';
import 'package:word_stock/pages/word-history/word-history.dart';
import 'package:word_stock/services/ad_manager.dart';
import 'package:word_stock/services/word_service.dart';
import 'package:flutter/material.dart';
import 'widgets/points/points_widget.dart';
import 'widgets/points/streak_widget.dart';
import 'widgets/word/word.dart';

const String testDevice = 'Pixel_3a_XL_API_30';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Stats> _getStats = getStats();

  BannerAd _bannerAd;
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  final _linkStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    _bannerAd = createBannerAd()
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
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
            appBar: AppBar(title: Text('Wordstock')),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                WordWidget(stats: snapshot.data),
                Flexible(
                  fit: FlexFit.tight,
                  child: PointsWidget(stats: snapshot.data),
                ),
                StreakWidget(stats: snapshot.data),
                AdBannerSpacer(),
              ],
            ),
            drawer: Drawer(
              child: SafeArea(
                child: ListView(
                  children: [
                    ListTile(
                        title: Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(Icons.history, size: 24.0)),
                            Text(
                              "Word History",
                              style: _linkStyle,
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WordHistoryPage()),
                          );
                        }),
                  ],
                ),
              ),
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
