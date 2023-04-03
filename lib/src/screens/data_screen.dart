import 'package:flutter/material.dart';

import '../widgets.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ScreenLayout(title: 'Daten', childs: <Widget>[
      p(themeData, 'test daten'),
      const SizedBox(height: 15),
      p(themeData, 'test123'),
      const SizedBox(height: 40),
    ]);
  }
}
