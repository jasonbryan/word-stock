import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({Key key}) : super(key: key);

  @override
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.star_border, size: 32.0),
      Icon(Icons.star_border, size: 32.0),
      Icon(Icons.star_border, size: 32.0),
      Icon(Icons.star_border, size: 32.0),
      Icon(Icons.star_border, size: 32.0),
      Icon(Icons.star_border, size: 32.0),
      Icon(Icons.star_border, size: 32.0)
    ]);
  }
}
