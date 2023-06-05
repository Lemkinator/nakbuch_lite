import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

import 'buch.dart';
import 'nakbuch.dart';
import 'hymn.dart';

NAKBuch? _nakbuch;

initStorage() async {
  await GetStorage.init();
  await GetStorage.init('nakbuch');
  await Hive.initFlutter();
  await Hive.openBox('pdf');
  String? nakBuchString = GetStorage('nakbuch').read('nakbuch');
  if (nakBuchString == null) {
    await setDefaultNAKBuch();
  } else {
    _nakbuch = NAKBuch.fromJson(jsonDecode(nakBuchString));
  }
}

//ThemeMode
ThemeMode getThemeMode() {
  var storedThemeMode = GetStorage().read('themeMode');
  if (storedThemeMode == null) return ThemeMode.system;
  if (storedThemeMode == 'ThemeMode.dark') {
    return ThemeMode.dark;
  } else if (storedThemeMode == 'ThemeMode.light') {
    return ThemeMode.light;
  } else {
    return ThemeMode.system;
  }
}

setThemeMode(ThemeMode themeMode) {
  GetStorage().write('themeMode', themeMode.toString());
}

//TextSize
double getFontSizeFactor() => GetStorage().read('fontSizeFactor') ?? 1;

double increaseFontSizeFactor() {
  var textSize = getFontSizeFactor();
  if (textSize < 3) {
    GetStorage().write('fontSizeFactor', textSize + 0.25);
  }
  return getFontSizeFactor();
}

double decreaseFontSizeFactor() {
  var textSize = getFontSizeFactor();
  if (textSize > 0.75) {
    GetStorage().write('fontSizeFactor', textSize - 0.25);
  }
  return getFontSizeFactor();
}

//Current Buch
String getCurrentBuchId() => GetStorage().read('buch') ?? 'gb';

Buch getCurrentBuch() => getBuch(getCurrentBuchId()) ?? getBuecher().first;

Function listenToCurrentBuchId(Function(dynamic) callback) => GetStorage().listenKey('buch', callback);

String setCurrentBuchId(String buchId) {
  if (getBuch(buchId) == null) return getCurrentBuchId();
  GetStorage().write('buch', buchId);
  return buchId;
}

//Current Hymn
String getCurrentNummer() => GetStorage().read('nummer') ?? '';

setCurrentNummer(String nummer) => GetStorage().write('nummer', nummer);

//NAKBuch
setDefaultNAKBuch() async {
  final nakbuchString = await rootBundle.loadString('assets/nakbuchNoCopyright_v5.0.3.json');
  _nakbuch = NAKBuch.fromJson(jsonDecode(nakbuchString));
  GetStorage('nakbuch').write('nakbuch', nakbuchString);
}

setNAKBuch(NAKBuch nakbuch) {
  _nakbuch = nakbuch;
  GetStorage('nakbuch').write('nakbuch', jsonEncode(nakbuch));
}

NAKBuch getNAKBuch() => _nakbuch!;

List<Buch> getBuecher() => getNAKBuch().buecher;

List<Hymn> getHymns() => getNAKBuch().lieder;

Buch? getBuch(String buchId) => getBuecher().firstWhereOrNull((buch) => buch.id == buchId);

List<Hymn> getHymnsWithBuchId(String buchId) => getHymns().where((hymn) => hymn.buchId == buchId).toList();

Hymn? getHymn(String buchId, int nummer) => getHymns().firstWhereOrNull((hymn) => hymn.buchId == buchId && hymn.nummer == nummer);

//PDF
FutureOr<Uint8List> getPDF(String buchId) => Hive.box('pdf').get(buchId);

setPDF(String buchId, Uint8List pdf) => Hive.box('pdf').put(buchId, pdf);

hasPDF(String buchId) => Hive.box('pdf').containsKey(buchId);

deleteAllPDFs() => Hive.box('pdf').clear();
