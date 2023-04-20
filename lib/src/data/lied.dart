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

  static unknown(int? number) => Lied(
      number: number ?? 0,
      rubric: 0,
      title: '??',
      text: 'Das Lied mit der Nummer $number aus dem ${Buch.current().name()} kenne ich nicht :(',
      copyright: '');
}

int? numberFromString(Buch buch, String? number) {
  final intNumber = int.tryParse(number ?? '');
  if (intNumber == null || intNumber < 1) {
    return null;
  }
  if (buch == Buch.gesangbuch) {
    if (intNumber <= 438) {
      return intNumber;
    }
  } else if (buch == Buch.chorbuch) {
    if (intNumber <= 462) {
      return intNumber;
    }
  } else if (buch == Buch.jugendliederbuch) {
    if (intNumber <= 102) {
      return intNumber;
    }
  } else if (buch == Buch.jbergaenzungsheft) {
    if (intNumber <= 20) {
      return intNumber;
    }
  }
  return null;
}

Lied getLied(Buch buch, int? number) {
  final lieder = getLieder(buch);
  if (number != null && number > 0 && number <= lieder.length) {
    return lieder[number - 1];
  } else {
    return Lied.unknown(number);
  }
}

List<Lied> getLieder(Buch buch) {
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
