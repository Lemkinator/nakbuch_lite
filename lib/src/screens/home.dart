import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets.dart';
import 'home_body.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.themeMode,
    required this.handleThemeModeChange,
    required this.handleBuchChange,
  });

  final ThemeMode themeMode;
  final void Function(ThemeMode?) handleThemeModeChange;
  final void Function(Buch) handleBuchChange;

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('${getCurrentBuch().title} - NAK Buch Lite'),
          actions: appBarActions(
            context,
            themeMode,
            handleThemeModeChange,
            getCurrentBuch(),
            handleBuchChange,
          )),
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const HomeScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/${getCurrentBuch().id}');
          if (idx == 1) routeState.go('/${getCurrentBuch().id}/liste');
          if (idx == 2) routeState.go('/info');
        },
        destinations: const [
          NavigationDestination(
            tooltip: '',
            icon: Icon(Icons.apps_rounded),
            label: 'Nummer',
            selectedIcon: Icon(Icons.apps_rounded),
          ),
          NavigationDestination(
            tooltip: '',
            icon: Icon(Icons.list),
            label: 'Liste',
            selectedIcon: Icon(Icons.list),
          ),
          NavigationDestination(
            tooltip: '',
            icon: Icon(Icons.info_outline),
            label: 'Info',
            selectedIcon: Icon(Icons.info_outline),
          ),
        ],
        trailing: NavigationTrailing(
          themeMode: themeMode,
          handleThemeModeChange: handleThemeModeChange,
          buch: getCurrentBuch(),
          handleBuchChange: handleBuchChange,
        ),
      ),
    );
  }

  int _getSelectedIndex(ParsedRoute route) {
    if (route.path == '/info') return 2;
    if (route.pathTemplate == '/:buch/liste') return 1;
    return 0;
  }
}
