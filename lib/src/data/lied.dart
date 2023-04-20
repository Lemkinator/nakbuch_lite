import 'dart:convert';

import 'package:get_storage/get_storage.dart';

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

  static unknown(int number) => Lied(
      number: number,
      rubric: 0,
      title: '??',
      text: 'Das Lied mit der Nummer $number aus dem ${Buch.current().name()} kenne ich nicht :(',
      copyright: '');
}

List<Lied> getLieder() {
  Buch buch = Buch.current();
  String? jsonString = GetStorage('custom_lieder').read(buch.path());
  jsonString ??= GetStorage('lieder').read(buch.path());
  return jsonDecode(jsonString!)
      .map<Lied>((json) => Lied(
            number: json['hymnNr'],
            rubric: json['hymnRubricIndex'],
            title: json['hymnTitle'],
            text: json['hymnText'],
            copyright: json['hymnCopyright'],
          ))
      .toList();
}

Future<Lied> getLied(int number) async {
  var lieder = getLieder();
  if (number > 0 && number <= lieder.length) {
    return lieder[number - 1];
  } else {
    return Lied.unknown(number);
  }
}
