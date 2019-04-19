import 'package:avis/ui/view/homepage.dart';
import 'package:flutter/material.dart';

import 'common/AppShareData.dart';
import 'ui/view/SearchPage.dart';
import 'ui/view/SearchResultPage.dart';
import 'ui/view/UnknownPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppShareData.AppName,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: _routes,
      onGenerateRoute: _getRoute,
      onUnknownRoute: _unknowRoute,
    );
  }

  Route<dynamic> _unknowRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => UnknownPage(),
    );
  }

  Map<String, WidgetBuilder> _routes = {
    AppRoutes.Home: (BuildContext context) => HomePage(),
    AppRoutes.Search: (BuildContext context) => SearchPage(),
  };

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.SearchResult) {
      final Map<String, dynamic> argv = settings.arguments;
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => SearchResultPage(
            argv[AppRoutes.SearchResultArg_type],
            argv[AppRoutes.SearchResultArg_keyword]),
      );
    }
    // The other paths we support are in the routes table.
    return null;
  }
}
