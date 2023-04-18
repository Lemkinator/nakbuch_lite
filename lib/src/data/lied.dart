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
}

List<Lied> getLieder(Buch buch) {
  var jsonString = GetStorage().read('custom_${buch.name()}_lieder');
  jsonString ??= GetStorage().read('${buch.name()}_lieder');
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

Future<Lied> getLied(Buch buch, int number) async {
  var lieder = getLieder(buch);
  if (number > 0 && number <= lieder.length) {
    return lieder[number - 1];
  } else {
    return Lied(number: number, rubric: 0, title: '??', text: 'Das Lied mit der Nummer $number aus dem ${buch.name()} kenne ich nicht :(', copyright: '');
  }
}
