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
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ScaleTransition(
            scale: _animation,
            alignment: Alignment.center,
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
          Text('Stars')
        ],
      ),
    );
  }
}
