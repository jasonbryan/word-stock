import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({Key key}) : super(key: key);

  @override
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _getStreak() async {
    final SharedPreferences prefs = await _prefs;
    return (prefs.getInt('streak') ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getStreak(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Text('Error loading Streak.');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              for (var i = 0; i < snapshot.data; i++)
                Icon(Icons.star, size: 32.0),
              for (var i = 0; i < (5 - snapshot.data); i++)
                Icon(Icons.star_border, size: 32.0)
            ]);
          }
          return Container();
        });
  }
}
