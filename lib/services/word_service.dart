import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

Future<Word> getWord() async {
  Word word;
  int min = 100000000;
  int max = 999999999;
  Random rnd = new Random();
  int num = min + rnd.nextInt(max - min);
  CollectionReference words = FirebaseFirestore.instance.collection('words');
  var temp =
      await words.where('id', isGreaterThanOrEqualTo: num).limit(1).get();
  word = Word.fromJson(temp.docs[0].data());
  print(num.toString() + "   " + word.id.toString() + "  " + word.word);
  return word;
}

Future<void> updateStats() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int streak = prefs.getInt('streak') ?? 0;
  int points = prefs.getInt('points') ?? 0;
  String word = prefs.getString('word') ?? '';
  String definition = prefs.getString('definition') ?? '';
  String lastViewedDate = prefs.getString('lastViewedDate') ?? '';
  List<String> previousWords =
      prefs.getStringList('previousWords') ?? new List<String>();
  final DateTime now = DateTime.now();
  final DateTime yesterday = DateTime.now().add(new Duration(days: -1));
  final DateFormat formatter = DateFormat('yyyy.MM.dd');
  final String nowString = formatter.format(now);
  final String yesterdayString = formatter.format(yesterday);

  if (nowString != lastViewedDate) {
    Word wordObj = await getWord();
    word = wordObj.word;
    while (previousWords.contains(word)) {
      wordObj = await getWord();
      word = wordObj.word;
    }
    previousWords.add(word);
    definition = wordObj.results[0].definition;
    points += 1; // Daily point
    streak += 1; // Increment streak
    if (yesterdayString == lastViewedDate) {
      if ((streak % 5) == 0) {
        points += 5; // Streak Bonus (+5)
      }
    } else {
      streak = 1;
    }
    await prefs.setInt('streak', streak);
    await prefs.setInt('points', points);
    await prefs.setString('word', word);
    await prefs.setString('definition', definition);
    await prefs.setStringList('previousWords', previousWords);
  }

  await prefs.setString('lastViewedDate', nowString);
}

Future<Stats> getStats() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Stats stats = new Stats();
  stats.streak = prefs.getInt('streak') ?? 0;
  stats.points = prefs.getInt('points') ?? 0;
  stats.word = prefs.getString('word') ?? '';
  stats.definition = prefs.getString('definition') ?? '';
  stats.lastViewedDate = prefs.getString('lastViewedDate') ?? '';
  return stats;
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

class Stats {
  int streak;
  int points;
  String lastViewedDate;
  String word;
  String definition;
}
