import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

enum Buch {
  gesangbuch,
  chorbuch,
  jugendliederbuch,
  jbergaenzungsheft;

  static Buch current() => _fromPathString(GetStorage().read('buch'));

  String name() {
    switch (this) {
      case Buch.gesangbuch:
        return 'Gesangbuch';
      case Buch.chorbuch:
        return 'Chorbuch';
      case Buch.jugendliederbuch:
        return 'Jugendliederbuch';
      case Buch.jbergaenzungsheft:
        return 'JB-Ergänzungsheft';
    }
  }

  String path() {
    switch (this) {
      case Buch.gesangbuch:
        return 'gesangbuch';
      case Buch.chorbuch:
        return 'chorbuch';
      case Buch.jugendliederbuch:
        return 'jugendliederbuch';
      case Buch.jbergaenzungsheft:
        return 'jbergaenzungsheft';
    }
  }

  static Buch _fromPathString(String? name) {
    switch (name) {
      case 'chorbuch':
        return Buch.chorbuch;
      case 'jugendliederbuch':
        return Buch.jugendliederbuch;
      case 'jbergaenzungsheft':
        return Buch.jbergaenzungsheft;
      default:
        return Buch.gesangbuch;
    }
  }

  String assetFileName() {
    switch (this) {
      case Buch.gesangbuch:
        return 'assets/hymnsGesangbuchNoCopyright.json';
      case Buch.chorbuch:
        return 'assets/hymnsChorbuchNoCopyright.json';
      case Buch.jugendliederbuch:
        return 'assets/hymnsJugendliederbuchNoCopyright.json';
      case Buch.jbergaenzungsheft:
        return 'assets/hymnsJBErgaenzungsheftNoCopyright.json';
    }
  }

  String route() {
    switch (this) {
      case Buch.gesangbuch:
        return '/gesangbuch';
      case Buch.chorbuch:
        return '/chorbuch';
      case Buch.jugendliederbuch:
        return '/jugendliederbuch';
      case Buch.jbergaenzungsheft:
        return '/jbergaenzungsheft';
    }
  }

  static init() async {
    for (var buch in Buch.values) {
      String jsonString = await rootBundle.loadString(buch.assetFileName());
      GetStorage().write('${buch.name()}_lieder', jsonString);
    }
  }
}
