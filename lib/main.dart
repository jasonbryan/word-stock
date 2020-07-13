import 'package:flutter/material.dart';
import 'package:word_stock/word_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word Stock',
      theme: ThemeData(
        fontFamily: 'Mitr',
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Word Stock'),
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
  final _biggerFont = const TextStyle(fontSize: 42.0, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.menu),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder<Word>(
              future: _futureWord,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Text(
                        snapshot.data.word,
                        style: _biggerFont,
                      ),
                      if(snapshot.data.results != null)
                        Text(snapshot.data.results[0].definition)
                      else
                        Text("No Definition")
                    ]
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
