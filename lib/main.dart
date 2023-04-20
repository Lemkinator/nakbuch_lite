import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app.dart';
import 'src/data.dart';

main() async {
  // Use package:url_strategy until this pull request is released:
  // https://github.com/flutter/flutter/pull/77103

  // Use to setHashUrlStrategy() to use "/#/" in the address bar (default). Use
  // setPathUrlStrategy() to use the path. You may need to configure your web
  // server to redirect all paths to index.html.
  //
  // On mobile platforms, both functions are no-ops.
  setHashUrlStrategy();
  // setPathUrlStrategy();
  await GetStorage.init();
  await GetStorage.init('data');
  await GetStorage.init('lieder');
  await GetStorage.init('custom_lieder');
  await Hive.initFlutter();
  await Hive.openBox('pdf');
  await Buch.init();
  setupWindow();
  runApp(const Home());
}

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('NAK Buch Lite');
  }
}
