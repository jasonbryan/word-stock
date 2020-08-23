import 'package:flutter/material.dart';
import 'package:word_stock/word/word_service.dart';

class WordWidget extends StatefulWidget {
  const WordWidget({Key key}) : super(key: key);

  @override
  _WordWidgetState createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  Future<Word> _futureWord = getWord();
  final _biggerFont =
      const TextStyle(fontSize: 42.0, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<Word>(
      future: _futureWord,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                Text(
                  snapshot.data.word,
                  style: _biggerFont,
                ),
                Text(snapshot.data.results[0].definition,
                    textAlign: TextAlign.center)
              ]));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container(
            padding: const EdgeInsets.all(50.0),
            child: CircularProgressIndicator());
      },
    ));
  }
}
