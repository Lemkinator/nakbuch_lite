import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';

class Lied {
  final int number;
  final int rubric;
  final String title;
  final String text;
  final String copyright;

  Lied({
    required this.number,
    required this.rubric,
    required this.title,
    required this.text,
    required this.copyright,
  });

  String numberAndTitle() => '$number. $title';
}

Future<List<Lied>> getLieder(Buch buch, Future<SharedPreferences> futurePrefs) async {
  var prefs = await futurePrefs;
  var jsonString = prefs.getString('${buch.name()}_lieder');
  jsonString ??= await rootBundle.loadString(buch.assetFileName());
  return jsonDecode(jsonString)
      .map<Lied>((json) => Lied(
            number: json['hymnNr'],
            rubric: json['hymnRubricIndex'],
            title: json['hymnTitle'],
            text: json['hymnText'],
            copyright: json['hymnCopyright'],
          ))
      .toList();
}

Future<Lied> getLied(Buch buch, int number, Future<SharedPreferences> futurePrefs) async {
  var lieder = await getLieder(buch, futurePrefs);
  if (number > 0 && number <= lieder.length) {
    return lieder[number - 1];
  } else {
    return Lied(number: number, rubric: 0, title: '??', text: 'Das Lied mit der Nummer $number aus dem ${buch.name()} kenne ich nicht :(', copyright: '');
  }
}
