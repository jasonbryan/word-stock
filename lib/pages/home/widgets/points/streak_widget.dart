import 'package:wordstock/services/word_service.dart';
import 'package:flutter/material.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({Key key, this.stats}) : super(key: key);
  final Stats stats;
  @override
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Streak Bonus"),
              content: new Text(
                  "Get a bonus 5 stars ever 5 day streak. Streak total will continues to accumuilate."),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  final _streakFont = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              widget.stats.streak.toString() +
                  (widget.stats.streak > 1 ? ' days' : ' day'),
              style: _streakFont,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var i = 0; i < (widget.stats.streak % 5); i++)
                Icon(Icons.whatshot, size: 32.0),
            ],
          ),
          InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Streak Bonus',
                  ),
                ),
                Icon(
                  Icons.info_outline,
                  size: 16.0,
                ),
              ],
            ),
            onTap: () {
              _showMaterialDialog();
            },
          ),
        ],
      ),
    );
  }
}
