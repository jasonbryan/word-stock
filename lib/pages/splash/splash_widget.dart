import 'package:flutter/material.dart';
import 'dart:async';

import 'package:word_stock/pages/home/home_widget.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashFont = TextStyle(fontSize: 56.0, fontWeight: FontWeight.w700);
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
      Navigator.of(context).pushReplacement(_createRoute());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Wordstock', style: _splashFont)));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        HomePage(title: 'Wordstock'),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 1200),
  );
}
