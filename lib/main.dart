import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:word_stock/pages/splash/splash_widget.dart';
import 'services/push_notification_manager.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebaseInits = Future.wait([
      PushNotificationsManager().init(),
      Firebase.initializeApp(),
    ]);
    return FutureBuilder(
      // Initialize FlutterFire
      future: _firebaseInits,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Error Found");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wordstock',
            theme: ThemeData(
              fontFamily: 'Mitr',
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: SplashPage(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
