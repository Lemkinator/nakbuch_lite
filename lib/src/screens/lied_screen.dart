import 'package:flutter/material.dart';

import '../data.dart';
import '../widgets.dart';

class LiedScreen extends StatelessWidget {
  const LiedScreen({
    super.key,
    required this.buch,
    required this.nummer,
  });

  final Buch buch;
  final int nummer;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Lied lied = getLied(buch, nummer);

    return ScreenLayout(title: '${lied.title} - ${buch.name()}', childs: <Widget>[
      p(themeData, lied.text),
      const SizedBox(height: 15),
      p(themeData, lied.copyright),
      const SizedBox(height: 40),
    ]);
  }
}
