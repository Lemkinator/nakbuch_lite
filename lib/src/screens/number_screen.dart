import 'package:flutter/material.dart';

import '../widgets.dart';

class NumberScreen extends StatelessWidget {
  const NumberScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ScreenLayout(title: 'Nummer', childs: <Widget>[
      p(themeData, 'test nummer'),
      const SizedBox(height: 15),
      p(themeData, 'test123'),
      const SizedBox(height: 40),
    ]);
  }
}
