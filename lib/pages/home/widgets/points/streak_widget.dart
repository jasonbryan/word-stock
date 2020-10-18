import 'package:Wordstock/services/word_service.dart';
import 'package:flutter/material.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({Key key, this.stats}) : super(key: key);
  final Stats stats;
  @override
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          for (var i = 0; i < widget.stats.streak; i++)
            Icon(Icons.star, size: 32.0),
          for (var i = 0; i < (5 - widget.stats.streak); i++)
            Icon(Icons.star_border, size: 32.0)
        ]),
        Text('Streak')
      ],
    );
  }
}
