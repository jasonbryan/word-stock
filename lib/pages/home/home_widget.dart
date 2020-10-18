import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:word_stock/ad/ad_widget.dart';

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
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> _updateStats() async {
    final SharedPreferences prefs = await _prefs;
    int streak = prefs.getInt('streak') ?? 0;
    int points = prefs.getInt('points') ?? 0;
    String lastViewedDate = prefs.getString('lastViewedDate') ?? '';
    final DateTime now = DateTime.now();
    final DateTime yesterday = DateTime.now().add(new Duration(days: -1));
    final DateFormat formatter = DateFormat('yyyy.MM.dd');
    final String nowString = formatter.format(now);
    final String yesterdayString = formatter.format(yesterday);
    setState(() {
      if (nowString != lastViewedDate) {
        points += 1; // Daily point
        streak += 1; // Increment streak
        if (yesterdayString == lastViewedDate) {
          if (streak == 5) {
            points += 5; // Streak Bonus (+5)
          } else if (streak == 6) {
            streak =
                1; // Don't want to rest till 6 so user can see 5 star streak
          }
        }
      }
      prefs.setInt('streak', streak);
      prefs.setInt('points', points);
      prefs.setString('lastViewedDate', nowString);
    });
  }

  @override
  void initState() {
    _updateStats();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
            child: Column(children: <Widget>[
          WordWidget(),
          PointsWidget(),
          StreakWidget(),
          AdWidget(),
        ])));
  }
}
