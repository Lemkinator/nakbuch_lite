import 'package:flutter/material.dart';
import 'home.dart';
import '../data/constants.dart';
import '../routing.dart';
import '../widgets/fade_transition_page.dart';
import '../screens.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class HomeNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final bool useLightMode;
  final ColorSeed colorSelected;
  final void Function(bool) handleBrightnessChange;
  final void Function(int) handleColorSelect;

  const HomeNavigator({
    super.key,
    required this.navigatorKey,
    required this.useLightMode,
    required this.colorSelected,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
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
    final buch = buchFromRoute(pathTemplate);

    int? lied;
    if (pathTemplate == '${buch.route()}/lied/:liedId') {
      lied = int.tryParse(routeState.route.parameters['liedId'] ?? '');
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /books or /authors tab in HomeScaffold.
        if (route.settings is Page) {
          routeState.go(buch.route());
        }

        return route.didPop(result);
      },
      pages: [
        ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: HomeScaffold(
              useLightMode: widget.useLightMode,
              colorSelected: widget.colorSelected,
              handleBrightnessChange: widget.handleBrightnessChange,
              handleColorSelect: widget.handleColorSelect,
            ),
          ),
          // Add an additional page to the stack if the user is viewing an app or media
          if (lied != null)
            MaterialPage<void>(
              child: LiedScreen(
                buch: buch,
                nummer: lied,
              ),
            ),
        ],
      ],
    );
  }
}
