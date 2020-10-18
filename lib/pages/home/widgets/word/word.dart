import 'package:flutter/material.dart';
import 'package:Wordstock/services/word_service.dart';

class WordWidget extends StatefulWidget {
  const WordWidget({Key key, this.stats}) : super(key: key);
  final Stats stats;
  @override
  _WordWidgetState createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  final _biggerFont =
      const TextStyle(fontSize: 42.0, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Text(
                widget.stats.word,
                style: _biggerFont,
              ),
              Text(widget.stats.definition, textAlign: TextAlign.center)
            ])));
  }
}
