import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/data.dart';

main() async {
  //usePathUrlStrategy(); //Dont use "/#/" in the address bar (default). You may need to configure your web server to redirect all paths to index.html.
  await initStorage();
  runApp(const Home());
}
