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
      case '/gb/:lied':
        if (hasPDF(Buch.gesangbuch)) {
          parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/gb/', '/gesangbuch/noten/'),
              parsedRoute.pathTemplate.replaceFirst('/gb/', '/gesangbuch/noten/'), parsedRoute.parameters, parsedRoute.queryParameters);
        } else {
          parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/gb/', '/gesangbuch/text/'),
              parsedRoute.pathTemplate.replaceFirst('/gb/', '/gesangbuch/text/'), parsedRoute.parameters, parsedRoute.queryParameters);
        }
        break;
      case '/cb/:lied':
        if (hasPDF(Buch.chorbuch)) {
          parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/cb/', '/chorbuch/noten/'),
              parsedRoute.pathTemplate.replaceFirst('/cb/', '/chorbuch/noten/'), parsedRoute.parameters, parsedRoute.queryParameters);
        } else {
          parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/cb/', '/chorbuch/text/'),
              parsedRoute.pathTemplate.replaceFirst('/cb/', '/chorbuch/text/'), parsedRoute.parameters, parsedRoute.queryParameters);
        }
        break;
      case '/jb/:lied':
        if (hasPDF(Buch.jugendliederbuch)) {
          parsedRoute = ParsedRoute(
              parsedRoute.path.replaceFirst('/jb/', '/jugendliederbuch/noten/'),
              parsedRoute.pathTemplate.replaceFirst('/jb/', '/jugendliederbuch/noten/'),
              parsedRoute.parameters,
              parsedRoute.queryParameters);
        } else {
          parsedRoute = ParsedRoute(
              parsedRoute.path.replaceFirst('/jb/', '/jugendliederbuch/text/'),
              parsedRoute.pathTemplate.replaceFirst('/jb/', '/jugendliederbuch/text/'),
              parsedRoute.parameters,
              parsedRoute.queryParameters);
        }
        break;
      case '/jbe/:lied':
        if (hasPDF(Buch.jbergaenzungsheft)) {
          parsedRoute = ParsedRoute(
              parsedRoute.path.replaceFirst('/jbe/', '/jbergaenzungsheft/noten/'),
              parsedRoute.pathTemplate.replaceFirst('/jbe/', '/jbergaenzungsheft/noten/'),
              parsedRoute.parameters,
              parsedRoute.queryParameters);
        } else {
          parsedRoute = ParsedRoute(
              parsedRoute.path.replaceFirst('/jbe/', '/jbergaenzungsheft/text/'),
              parsedRoute.pathTemplate.replaceFirst('/jbe/', '/jbergaenzungsheft/text/'),
              parsedRoute.parameters,
              parsedRoute.queryParameters);
        }
        break;
      case '/gb':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/gb', '/gesangbuch'),
            parsedRoute.pathTemplate.replaceFirst('/gb', '/gesangbuch'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/cb':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/cb', '/chorbuch'),
            parsedRoute.pathTemplate.replaceFirst('/cb', '/chorbuch'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/jb':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/jb', '/jugendliederbuch'),
            parsedRoute.pathTemplate.replaceFirst('/jb', '/jugendliederbuch'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
      case '/jbe':
        parsedRoute = ParsedRoute(parsedRoute.path.replaceFirst('/jbe', '/jbergaenzungsheft'),
            parsedRoute.pathTemplate.replaceFirst('/jbe', '/jbergaenzungsheft'), parsedRoute.parameters, parsedRoute.queryParameters);
        break;
    }
    var root = parsedRoute.pathTemplate.split('/')[1];
    if (root == 'gesangbuch' || root == 'chorbuch' || root == 'jugendliederbuch' || root == 'jbergaenzungsheft') {
      GetStorage().write('buch', parsedRoute.pathTemplate.split('/')[1]);
    }
    if (parsedRoute.parameters.containsKey('lied')) {
      int? lied = int.tryParse(parsedRoute.parameters['lied'] ?? '');
      if (lied != null) {
        GetStorage().write('lied', lied.toString());
      }
    }

    if (parsedRoute.pathTemplate.contains("/noten") && !hasPDF(Buch.current())) {
      parsedRoute = ParsedRoute(
          parsedRoute.path.replaceFirst('/noten/', '/text/').replaceFirst('/noten', ''),
          parsedRoute.pathTemplate.replaceFirst('/noten/', '/text/').replaceFirst('/noten', ''),
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
