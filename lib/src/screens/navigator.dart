import 'package:flutter/material.dart';
import 'home.dart';
import '../data.dart';
import '../routing.dart';
import '../widgets/fade_transition_page.dart';
import '../screens.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class HomeNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final ThemeMode themeMode;
  final void Function(ThemeMode?) handleThemeModeChange;
  final void Function(Buch) handleBuchChange;

  const HomeNavigator({
    super.key,
    required this.navigatorKey,
    required this.themeMode,
    required this.handleThemeModeChange,
    required this.handleBuchChange,
  });

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  final _scaffoldKey = const ValueKey('App scaffold');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;
    final buch = Buch.current();

    int? textLied;
    if (pathTemplate == '${buch.route()}/text/:lied') {
      textLied = int.tryParse(routeState.route.parameters['lied'] ?? '');
    }
    int? notenLied;
    if (pathTemplate == '${buch.route()}/noten/:lied') {
      notenLied = int.tryParse(routeState.route.parameters['lied'] ?? '');
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /books or /authors tab in HomeScaffold.
        if (route.settings is Page) {
          routeState.go(buch.route());
        }
        /*if (route.settings is Page &&
            (route.settings as Page).key == _scaffoldKey) {
          routeState.go('/');
        }*/

        return route.didPop(result);
      },
      pages: [
        ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: HomeScaffold(
              themeMode: widget.themeMode,
              handleThemeModeChange: widget.handleThemeModeChange,
              handleBuchChange: widget.handleBuchChange,
            ),
          ),
          // Add an additional page to the stack if the user is viewing an app or media
          if (textLied != null)
            MaterialPage<void>(
              child: LiedScreen(
                nummer: textLied,
              ),
            ),
          if (pathTemplate == '${buch.route()}/noten')
            const MaterialPage<void>(
              child: PDFScreen(),
            ),
          if (notenLied != null)
            MaterialPage<void>(
              child: PDFScreen(
                nummer: notenLied,
              ),
            ),
        ],
      ],
    );
  }
}
