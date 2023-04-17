import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final Future<Lied> lied = getLied(buch, nummer, prefs, DefaultAssetBundle.of(context));

    return FutureBuilder<Lied?>(
      future: lied,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildLiedScreen(themeData, snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLiedScreen(ThemeData themeData, Lied lied) {
    return ScreenLayout(title: '${lied.numberAndTitle()} - ${buch.name()}', childs: <Widget>[
      p(themeData, lied.text),
      const SizedBox(height: 40),
      p(themeData, lied.copyright),
      const SizedBox(height: 40),
    ]);
  }
}
