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
              content: new Text("Get 5 bonus stars after a 5 day streak!"),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var i = 0; i < widget.stats.streak; i++)
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
                    'Streak',
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
