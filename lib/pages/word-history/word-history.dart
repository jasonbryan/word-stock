import 'package:flutter/material.dart';
import 'package:word_stock/ad/ad_widget.dart';
import 'package:word_stock/services/word_service.dart';

class WordHistoryPage extends StatefulWidget {
  WordHistoryPage({Key key}) : super(key: key);
  static const String routeName = '/word-history';

  @override
  _WordHistoryPage createState() => _WordHistoryPage();
}

class _WordHistoryPage extends State<WordHistoryPage> {
  Future<Stats> _getStats = getStats();
  final _wordFont = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stats>(
      future: _getStats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Word History'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                for (var word in snapshot.data.previousWords)
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      word,
                      style: _wordFont,
                    ),
                  ),
                AdBannerSpacer(),
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
