import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../widgets.dart';

class LiedScreen extends StatelessWidget {
  const LiedScreen({
    super.key,
    required this.nummer,
  });

  final int nummer;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final List<Lied> lieder = getLieder();
    final lied = lieder.elementAtOrNull(nummer - 1) ?? Lied.unknown(nummer);

    return ScreenLayout(title: Buch.current().name(), childs: <Widget>[
      h3(themeData, lied.numberAndTitle()),
      mediumSpace(),
      p(themeData, lied.text),
      largeSpace(),
      p(themeData, lied.copyright),
      largeSpace(),
    ]);
  }
}
