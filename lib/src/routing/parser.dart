import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

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
      Buch buch = Buch.current();
      parsedRoute = ParsedRoute(buch.route(), buch.route(), parsedRoute.parameters, parsedRoute.queryParameters);
    }
    switch (parsedRoute.pathTemplate) {
      case '/':
        Buch buch = Buch.current();
        parsedRoute = ParsedRoute(buch.route(), buch.route(), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/gb/:liedId':
      case '/cb/:liedId':
      case '/jb/:liedId':
      case '/jbe/:liedId':
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
        break;
      case '/gb':
      case '/gb/daten':
      case '/gb/liste':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/gb', '/gesangbuch'),
            parsedRoute.pathTemplate.replaceFirst('/gb', '/gesangbuch'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/cb':
      case '/cb/daten':
      case '/cb/liste':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/cb', '/chorbuch'),
            parsedRoute.pathTemplate.replaceFirst('/cb', '/chorbuch'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/jb':
      case '/jb/daten':
      case '/jb/liste':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/jb', '/jugendliederbuch'),
            parsedRoute.pathTemplate.replaceFirst('/jb', '/jugendliederbuch'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/jbe':
      case '/jbe/daten':
      case '/jbe/liste':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/jbe', '/jbergaenzungsheft'),
            parsedRoute.pathTemplate.replaceFirst('/jbe', '/jbergaenzungsheft'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
    }
    GetStorage().write('buch', parsedRoute.pathTemplate.split('/')[1]);

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
