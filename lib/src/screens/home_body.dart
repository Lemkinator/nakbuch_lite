import 'package:flutter/material.dart';

import '../screens.dart';
import '../routing.dart';
import '../widgets/fade_transition_page.dart';

/// Displays the contents of the body of [HomeScaffold]
class HomeScaffoldBody extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const HomeScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentRoute = RouteStateScope.of(context).route;

    // A nested Router isn't necessary because the back button behavior doesn't
    // need to be customized.
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        if (currentRoute.path == '/info')
          const FadeTransitionPage<void>(
            key: ValueKey('info'),
            child: InfoScreen(),
          )
        else if (currentRoute.pathTemplate == '/:buch/liste')
          const FadeTransitionPage<void>(
            key: ValueKey('list'),
            child: ListScreen(),
          )
        else if (currentRoute.pathTemplate == '/:buch')
          const FadeTransitionPage<void>(
            key: ValueKey('number'),
            child: NumberScreen(),
          )

        // Avoid building a Navigator with an empty `pages` list when the RouteState is set to an unexpected path
        //
        // Since RouteStateScope is an InheritedNotifier, any change to the
        // route will result in a call to this build method, even though this
        // widget isn't built when those routes are active.
        else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}
