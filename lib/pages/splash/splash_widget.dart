import 'package:flutter/material.dart';

import 'package:word_stock/pages/home/home_widget.dart';
import 'package:word_stock/services/word_service.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  static const String routeName = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashFont = TextStyle(fontSize: 56.0, fontWeight: FontWeight.w700);
  final _subTextFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    final myfuture =
        Future.wait([updateStats(), Future.delayed(const Duration(seconds: 2))])
            .then((_) => Navigator.of(context).pushReplacement(_createRoute()));
    return FutureBuilder(
      future: myfuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Oops!",
                    style: _splashFont,
                  ),
                  Text(
                    "There was an issue loading your word. Please try again later.",
                    textAlign: TextAlign.center,
                    style: _subTextFont,
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {}
        return Scaffold(
            body: Center(child: Text('Wordstock', style: _splashFont)));
      },
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
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
    transitionDuration: const Duration(milliseconds: 1000),
  );
}
