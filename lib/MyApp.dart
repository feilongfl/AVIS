import 'package:flutter/material.dart';
import 'package:avis/ui/view/homepage.dart';

import 'ui/view/SearchPage.dart';
import 'ui/view/UnknownPage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> _routes = {
      '/':         (BuildContext context) => HomePage(),
      '/Search': (BuildContext context) => SearchPage(),
    };

    return MaterialApp(
      title: 'Flutter Demo',
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
    Route<dynamic> _getRoute(RouteSettings settings) {
//    if (settings.name == '/Search') {
//      final String symbol = settings.arguments;
//      return MaterialPageRoute<void>(
//        settings: settings,
//        builder: (BuildContext context) => SearchPage(),
//      );
//    }
    // The other paths we support are in the routes table.
    return null;
  }
}

