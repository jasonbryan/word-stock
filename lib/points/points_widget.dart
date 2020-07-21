import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsWidget extends StatefulWidget {
  const PointsWidget({Key key}) : super(key: key);

  @override
  _PointsWidgetState createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget>
    with SingleTickerProviderStateMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _counter;
  Future<void> _getCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0);

    setState(() {
      _counter = counter;
    });
  }

  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _getCounter();
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
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
        child: Column(children: <Widget>[
          ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: Column(children: <Widget>[Icon(Icons.star, size: 128.0)])),
          Text(_counter.toString())
        ]));
  }
}
