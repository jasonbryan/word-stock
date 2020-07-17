import 'package:flutter/material.dart';
import 'package:word_stock/word_service.dart';
import 'package:word_stock/ad_manager_test.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordstock',
      theme: ThemeData(
        fontFamily: 'Mitr',
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Wordstock'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Word> _futureWord = getWord();
  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  BannerAd _bannerAd;
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  final _biggerFont =
      const TextStyle(fontSize: 42.0, fontWeight: FontWeight.w700);

  @override
  void initState() {
    _initAdMob();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
            child: Column(children: <Widget>[
          Center(
            child: FutureBuilder<Word>(
              future: _futureWord,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: <Widget>[
                    Text(
                      snapshot.data.word,
                      style: _biggerFont,
                    ),
                    Text(snapshot.data.results[0].definition)
                  ]);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ])));
  }
}
