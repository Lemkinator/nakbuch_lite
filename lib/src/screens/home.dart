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
    final buch = buchFromRoute(routeState.route.path);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('NAK Buch Lite - ${buch.name()}'),
          actions: appBarActions(
            context,
            themeMode,
            handleThemeModeChange,
            buch,
            handleBuchChange,
          )),
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const HomeScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('${buch.route()}/');
          if (idx == 1) routeState.go('${buch.route()}/liste');
          if (idx == 2) routeState.go('${buch.route()}/daten');
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
            icon: Icon(Icons.data_usage_rounded),
            label: 'Daten',
            selectedIcon: Icon(Icons.data_usage_rounded),
          ),
        ],
        trailing: NavigationTrailing(
          themeMode: themeMode,
          handleThemeModeChange: handleThemeModeChange,
          buch: buch,
          handleBuchChange: handleBuchChange,
        ),
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    var buch = buchFromRoute(pathTemplate);
    if (pathTemplate.startsWith('${buch.route()}/liste')) return 1;
    if (pathTemplate.startsWith('${buch.route()}/daten')) return 2;
    return 0;
  }
}
