import 'dart:io';

import '../data.dart';

class Lied {
  final int number;
  final int rubric;
  final String title;
  final String text;
  final String copyright;
  final bool containsCopyRight;

  Lied({
    required this.number,
    required this.rubric,
    required this.title,
    required this.text,
    required this.copyright,
    required this.containsCopyRight,
  });
}

getLied(Buch buch, int number) {
  return Lied(
    number: number,
    rubric: 0,
    title: 'Lied $number',
    text: 'Text von $number\n123text text text\n123text asdfasdfasdfasdfasdfalsdkfjahsldkjfhaskldjfhalksdjhfakljdhflkajsdflkajsdhflkajsdflkjashdlfkjhasdkjfhalskdjfhlaksjdfhalskdjfhalksdjfhasdklfjahsdf text text\n123text text text\n123text text text',
    copyright: 'Copyright\nText von blabla',
    containsCopyRight: false,
  );
}
