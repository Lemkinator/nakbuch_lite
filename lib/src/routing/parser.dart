import 'package:flutter/widgets.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import 'parsed_route.dart';

/// Used by [TemplateRouteParser] to guard access to routes.
typedef RouteGuard<T> = Future<T> Function(T from);

/// Parses the URI path into a [ParsedRoute].
class TemplateRouteParser extends RouteInformationParser<ParsedRoute> {
  final List<String> _pathTemplates;
  final RouteGuard<ParsedRoute>? guard;
  final ParsedRoute initialRoute;

  TemplateRouteParser({
    /// The list of allowed path templates (['/', '/users/:id'])
    required List<String> allowedPaths,

    /// The initial route
    String initialRoute = '/',

    ///  [RouteGuard] used to redirect.
    this.guard,
  })  : initialRoute = ParsedRoute(initialRoute, initialRoute, {}, {}),
        _pathTemplates = [
          ...allowedPaths,
        ],
        assert(allowedPaths.contains(initialRoute));

  @override
  Future<ParsedRoute> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final path = routeInformation.location!;
    final queryParams = Uri.parse(path).queryParameters;
    var parsedRoute = initialRoute;

    for (var pathTemplate in _pathTemplates) {
      final parameters = <String>[];
      var pathRegExp = pathToRegExp(pathTemplate, parameters: parameters);
      if (pathRegExp.hasMatch(path)) {
        final match = pathRegExp.matchAsPrefix(path);
        if (match == null) continue;
        final params = extract(parameters, match);
        parsedRoute = ParsedRoute(path, pathTemplate, params, queryParams);
      }
    }

    if (parsedRoute.path == '/') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Buch? buch;
      if (prefs.getString('buch') == Buch.chorbuch.name()) {
        buch = Buch.chorbuch;
      } else if (prefs.getString('buch') == Buch.jugendliederbuch.name()) {
        buch = Buch.jugendliederbuch;
      } else if (prefs.getString('buch') == Buch.jbergaenzungsheft.name()) {
        buch = Buch.jbergaenzungsheft;
      } else {
        buch = Buch.gesangbuch;
      }
      parsedRoute = ParsedRoute(
          buch.route(),
          buch.route(),
          parsedRoute.parameters,
          parsedRoute.queryParameters);
    }
    // Redirect shortcuts
    else if (parsedRoute.pathTemplate == '/gb/:liedId' ||
        parsedRoute.pathTemplate == '/cb/:liedId' ||
        parsedRoute.pathTemplate == '/jb/:liedId' ||
        parsedRoute.pathTemplate == '/jbe/:liedId') {
      parsedRoute = ParsedRoute(
          parsedRoute.path
              .replaceFirst('/gb/', '/gesangbuch/lied/')
              .replaceFirst('/cb/', '/chorbuch/lied/')
              .replaceFirst('/jb/', '/jugendliederbuch/lied/')
              .replaceFirst('/jbe/', '/jbergaenzungsheft/lied/'),
          parsedRoute.pathTemplate
              .replaceFirst('/gb/', '/gesangbuch/lied/')
              .replaceFirst('/cb/', '/chorbuch/lied/')
              .replaceFirst('/jb/', '/jugendliederbuch/lied/')
              .replaceFirst('/jbe/', '/jbergaenzungsheft/lied/'),
          parsedRoute.parameters,
          parsedRoute.queryParameters);
    }
    else if (parsedRoute.pathTemplate == '/gb' ||
        parsedRoute.pathTemplate == '/cb' ||
        parsedRoute.pathTemplate == '/jb' ||
        parsedRoute.pathTemplate == '/jbe' ||
        parsedRoute.pathTemplate == '/gb/daten' ||
        parsedRoute.pathTemplate == '/cb/daten' ||
        parsedRoute.pathTemplate == '/jb/daten' ||
        parsedRoute.pathTemplate == '/jbe/daten' ||
        parsedRoute.pathTemplate == '/gb/liste' ||
        parsedRoute.pathTemplate == '/cb/liste' ||
        parsedRoute.pathTemplate == '/jb/liste' ||
        parsedRoute.pathTemplate == '/jbe/liste') {
      parsedRoute = ParsedRoute(
          parsedRoute.path
              .replaceFirst('/gb', '/gesangbuch')
              .replaceFirst('/cb', '/chorbuch')
              .replaceFirst('/jb', '/jugendliederbuch')
              .replaceFirst('/jbe', '/jbergaenzungsheft'),
          parsedRoute.pathTemplate
              .replaceFirst('/gb', '/gesangbuch')
              .replaceFirst('/cb', '/chorbuch')
              .replaceFirst('/jb', '/jugendliederbuch')
              .replaceFirst('/jbe', '/jbergaenzungsheft'),
          parsedRoute.parameters,
          parsedRoute.queryParameters);
    }

    // Redirect if a guard is present
    var guard = this.guard;
    if (guard != null) {
      return guard(parsedRoute);
    }

    return parsedRoute;
  }

  @override
  RouteInformation restoreRouteInformation(ParsedRoute configuration) => RouteInformation(location: configuration.path);
}
