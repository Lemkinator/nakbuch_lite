import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'data.dart';
import 'routing.dart';
import 'screens/navigator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;

  void handleThemeModeChange(ThemeMode? newThemeMode) {
    setState(() {
      if (newThemeMode != null) {
        themeMode = newThemeMode;
      } else {
        if (themeMode == ThemeMode.system) {
          themeMode = ThemeMode.dark;
        } else if (themeMode == ThemeMode.dark) {
          themeMode = ThemeMode.light;
        } else {
          themeMode = ThemeMode.system;
        }
      }
      setThemeMode(themeMode);
    });
  }

  void handleBuchChange(Buch buch) {
    var path = _routeState.route.path;
    var relativeRouteIndex = path.indexOf('/', 1);
    var relativeRoute = relativeRouteIndex == -1 ? '' : path.substring(relativeRouteIndex);
    _routeState.go('/${buch.id}$relativeRoute');
  }

  @override
  void initState() {
    themeMode = getThemeMode();

    /// Configure the parser with all of the app's allowed path templates. Last item has most priority.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/',
        '/:buch',
        '/info',
        '/:buch/:lied',
        '/:buch/liste',
        '/:buch/text/:lied',
        '/:buch/noten/:lied',
      ],
      initialRoute: '/',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => HomeNavigator(
        navigatorKey: _navigatorKey,
        themeMode: themeMode,
        handleThemeModeChange: handleThemeModeChange,
        handleBuchChange: handleBuchChange,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;

          if (lightDynamic != null && darkDynamic != null) {
            // On Android S+ devices, use the provided dynamic color scheme.
            // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
            lightColorScheme = lightDynamic.harmonized();
            // (Optional) Customize the scheme as desired. For example, one might
            // want to use a brand color to override the dynamic [ColorScheme.secondary].
            lightColorScheme = lightColorScheme.copyWith(secondary: nakbuchBlue);
            // Repeat for the dark color scheme.
            darkColorScheme = darkDynamic.harmonized();
            darkColorScheme = darkColorScheme.copyWith(secondary: nakbuchBlue);
          } else {
            // Otherwise, use fallback schemes.
            lightColorScheme = ColorScheme.fromSeed(
              seedColor: nakbuchBlue,
            );
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: nakbuchBlue,
              brightness: Brightness.dark,
            );
          }

          return RouteStateScope(
            notifier: _routeState,
            child: MaterialApp.router(
              routerDelegate: _routerDelegate,
              routeInformationParser: _routeParser,
              // Revert back to pre-Flutter-2.5 transition behavior:
              // https://github.com/flutter/flutter/issues/82053
              debugShowCheckedModeBanner: false,
              title: 'NAK Buch Lite',
              themeMode: themeMode,
              theme: ThemeData(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
                colorScheme: lightColorScheme,
                useMaterial3: useMaterial3,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
                colorScheme: darkColorScheme,
                useMaterial3: useMaterial3,
                brightness: Brightness.dark,
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
