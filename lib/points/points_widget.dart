import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PointsWidget extends StatefulWidget {
  const PointsWidget({Key key}) : super(key: key);

  @override
  _PointsWidgetState createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget>
    with SingleTickerProviderStateMixin {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _counter;
  Future<void> _getCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0);

    setState(() {
      _counter = counter;
    });
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': "Johen", // John Doe
          'company': "Stokes and Sons", // Stokes and Sons
          'age': 42 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _getCounter();
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
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
          Text(_counter.toString()),
          FlatButton(
              onPressed: addUser,
              child: Text(
                "Add User",
              )),
        ]));
  }
}
