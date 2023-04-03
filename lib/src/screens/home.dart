import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets.dart';
import 'home_body.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.useLightMode,
    required this.colorSelected,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
  });

  final bool useLightMode;
  final ColorSeed colorSelected;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final buch = buchFromRoute(routeState.route.pathTemplate);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('NAK Buch Lite - ${buch.name()}'),
          actions: appBarActions(
            context,
            colorSelected,
            handleBrightnessChange,
            handleColorSelect,
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
          useLightMode: useLightMode,
          colorSelected: colorSelected,
          handleBrightnessChange: handleBrightnessChange,
          handleColorSelect: handleColorSelect,
        ),
      ),
    );
  }

  Buch _getBuch(String pathTemplate) {
    if (pathTemplate.startsWith(Buch.chorbuch.route())) return Buch.chorbuch;
    if (pathTemplate.startsWith(Buch.jugendliederbuch.route())) return Buch.jugendliederbuch;
    if (pathTemplate.startsWith(Buch.jbergaenzungsheft.route())) return Buch.jbergaenzungsheft;
    return Buch.gesangbuch;
  }

  int _getSelectedIndex(String pathTemplate) {
    var buch = _getBuch(pathTemplate);
    if (pathTemplate.startsWith('${buch.route()}/liste')) return 1;
    if (pathTemplate.startsWith('${buch.route()}/daten')) return 2;
    return 0;
  }
}
