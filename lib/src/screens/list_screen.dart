import 'package:flutter/material.dart';

import '../widgets.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ScreenLayout(title: 'Liste', childs: <Widget>[
      p(themeData, 'test liste'),
      const SizedBox(height: 15),
      p(themeData, 'test123'),
      const SizedBox(height: 40),
    ]);
  }
}
