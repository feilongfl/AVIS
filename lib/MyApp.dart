import 'package:avis/ui/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'common/AppEnums.dart';
import 'common/AppShareData.dart';
import 'media/Media.dart';
import 'parse/BaseParse.dart';
import 'parse/Parse.dart';
import 'ui/model/SourceEditPageModel.dart';
import 'ui/view/AboutPage.dart';
import 'ui/view/AgentEditPage.dart';
import 'ui/view/BackupPage.dart';
import 'ui/view/MediaInfoPage.dart';
import 'ui/view/MediaViewPage.dart';
import 'ui/view/SearchPage.dart';
import 'ui/view/SearchResultPage.dart';
import 'ui/view/SourceEditPage.dart';
import 'ui/view/SourceSettingPage.dart';
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
    AppRoutes.About: (BuildContext context) => AboutPage(),
    AppRoutes.Backup: (BuildContext context) => BackupPage(),
    AppRoutes.SourceSetting: (BuildContext context) => SourceSettingPage(),
  };

  Route<dynamic> _unknowRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => UnknownPage(settings.name),
    );
  }

  static Parse _editingParse;

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
    if (settings.name == AppRoutes.MediaView) {
      final Map<String, dynamic> argv = settings.arguments;
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => MediaViewPage(
            argv[AppRoutes.MediaViewArg_Media],
            argv[AppRoutes.MediaViewArg_EposideId],
            argv[AppRoutes.MediaViewArg_ChapterId]),
      );
    }
    if (settings.name == AppRoutes.SourceEdit) {
      _editingParse =
          settings.arguments ?? BaseParse();
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => SourceEditPageModel(
              parse: _editingParse,
              child: SourceEditPage(),
            ),
      );
    }
    if (settings.name == AppRoutes.AgentsEdit) {
      ParseType argv = settings.arguments;
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => SourceEditPageModel(
              parse: _editingParse,
              child: AgentEditPage(argv),
            ),
      );
    }
    return null;
  }
}
