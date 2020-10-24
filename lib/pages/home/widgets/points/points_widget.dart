import 'package:word_stock/services/word_service.dart';
import 'package:flutter/material.dart';

class PointsWidget extends StatefulWidget {
  const PointsWidget({Key key, this.stats}) : super(key: key);
  final Stats stats;
  @override
  _PointsWidgetState createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final _pointsFont = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: ThemeData.dark().backgroundColor);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Stars"),
                content: new Text(
                    "You are given one star each day you view your word. Additional stars can be earned through your streak bonus."),
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

    return Container(
      padding: const EdgeInsets.only(
        right: 16.0,
        left: 16.0,
        top: 50.0,
        bottom: 75.0,
      ),
      child: Column(
        children: <Widget>[
          ScaleTransition(
            scale: _animation,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.star,
                  size: 250.0,
                ),
                Text(
                  widget.stats.points.toString(),
                  style: _pointsFont,
                ),
              ],
            ),
          ),
          InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Stars',
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
