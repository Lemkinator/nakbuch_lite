import 'package:flutter/material.dart';

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
        return 'hymnsGesangbuchNoCopyright.txt';
      case Buch.chorbuch:
        return 'hymnsChorbuchNoCopyright.txt';
      case Buch.jugendliederbuch:
        return 'hymnsJugendliederbuchNoCopyright.txt';
      case Buch.jbergaenzungsheft:
        return 'hymnsJBErgaenzungsheftNoCopyright.txt';
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

enum ColorSeed {
  baseColor(Color(0xff6750a4)),
  indigo(Colors.indigo),
  blue(Colors.blue),
  teal(Colors.teal),
  green(Colors.green),
  yellow(Colors.yellow),
  orange(Colors.orange),
  deepOrange(Colors.deepOrange),
  pink(Colors.pink);

  const ColorSeed(this.color);

  String localizedLabel() {
    switch (this) {
      case ColorSeed.baseColor:
        return 'M3 Baseline';
      case ColorSeed.indigo:
        return 'Indigo';
      case ColorSeed.blue:
        return 'Blue';
      case ColorSeed.teal:
        return 'Teal';
      case ColorSeed.green:
        return 'Green';
      case ColorSeed.yellow:
        return 'Yellow';
      case ColorSeed.orange:
        return 'Orange';
      case ColorSeed.deepOrange:
        return 'DeepOrange';
      case ColorSeed.pink:
        return 'Pink';
    }
  }

  final Color color;
}
