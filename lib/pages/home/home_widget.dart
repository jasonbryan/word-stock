import 'package:Wordstock/ad/ad_widget.dart';
import 'package:Wordstock/services/word_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
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

  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: FutureBuilder(
        future: _getStats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    WordWidget(stats: snapshot.data),
                    PointsWidget(stats: snapshot.data),
                    StreakWidget(stats: snapshot.data),
                    AdWidget(),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        },
      ),
      onRefresh: () async {
        _getStats = getStats();
      },
    );
  }
}
