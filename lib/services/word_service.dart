import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

Future<Word> getNewWord() async {
  Word word;
  int min = 100000000;
  int max = 999999999;
  Random rnd = new Random();
  int num = min + rnd.nextInt(max - min);
  CollectionReference words = FirebaseFirestore.instance.collection('words');
  var temp = await words
      .where('id', isGreaterThanOrEqualTo: num)
      .limit(1)
      .get()
      .then((QuerySnapshot querySnapshot) => querySnapshot.docs[0]);
  word = Word.fromJson(temp.data());
  print(num.toString() + "   " + word.id.toString() + "  " + word.word);
  return word;
}

Future<Word> getWord() async {
  Word word;
  http.Response response;
  while (word == null || word.results == null) {
    response = await http.get(
      'https://wordsapiv1.p.rapidapi.com/words/?random=true',
      headers: {
        "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
        "x-rapidapi-key": "a04afa4e2fmshedd292207503780p1fb7c6jsnf05c55f3e1d3",
        "useQueryString": "true"
      },
    );
    if (response.statusCode == 200) {
      word = Word.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Word');
    }
  }
  return word;
}

class Word {
  final int id;
  final String word;
  final List<dynamic> results;
  Word({this.id, this.word, this.results});
  factory Word.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    print(list.runtimeType);
    List<Item> resultList =
        list != null ? list.map((e) => (Item.fromJson(e))).toList() : null;

    return Word(id: json['id'], word: json['word'], results: resultList);
  }
}

class Item {
  final String definition;
  Item({this.definition});
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(definition: json['definition']);
  }
}
