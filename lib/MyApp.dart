import 'package:avis/ui/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'common/AppShareData.dart';
import 'media/Media.dart';
import 'ui/view/MediaInfoPage.dart';
import 'ui/view/SearchPage.dart';
import 'ui/view/SearchResultPage.dart';
import 'ui/view/UnknownPage.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends StateMVC {
  MyAppController controller = new MyAppController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppShareData.AppName,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: controller._routes,
      onGenerateRoute: controller._getRoute,
      onUnknownRoute: controller._unknowRoute,
    );
  }
}

class MyAppController extends ControllerMVC {
  final Map<String, WidgetBuilder> _routes = {
    AppRoutes.Home: (BuildContext context) => HomePage(),
    AppRoutes.Search: (BuildContext context) => SearchPage(),
  };

  Route<dynamic> _unknowRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => UnknownPage(settings.name),
    );
  }

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
    if (settings.name == AppRoutes.MediaInfo) {
      final Media media = settings.arguments;
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => MediaInfoPage(media),
      );
    }
    return null;
  }
}
