import 'package:wordstock/ad/ad_widget.dart';
import 'package:wordstock/services/word_service.dart';
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
                Flexible(
                    fit: FlexFit.tight,
                    child: PointsWidget(stats: snapshot.data)),
                StreakWidget(stats: snapshot.data),
                AdWidget(),
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
