import 'dart:ui';

const nakbuchBlue = Color(0xFF6989C9);

Buch buchFromRoute(String route) {
  if (route.startsWith(Buch.chorbuch.route())) return Buch.chorbuch;
  if (route.startsWith(Buch.jugendliederbuch.route())) return Buch.jugendliederbuch;
  if (route.startsWith(Buch.jbergaenzungsheft.route())) return Buch.jbergaenzungsheft;
  return Buch.gesangbuch;
}

enum Buch {
  gesangbuch,
  chorbuch,
  jugendliederbuch,
  jbergaenzungsheft;

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
}
