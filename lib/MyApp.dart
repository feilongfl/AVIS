import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'Agent/HttpAgent.dart';
import 'Agent/common/Agent.dart';
import 'common/AppRoutes.dart';
import 'generated/i18n.dart';
import 'parse/BaseParse.dart';
import 'parse/common/Parse.dart';
import 'parse/common/ParseAction.dart';
import 'ui/view/BackupPage.dart';
import 'ui/view/DonatePage.dart';
import 'ui/view/MediaViewer/common/ViewRoute.dart';
import 'ui/view/PictureViewer.dart';
import 'ui/view/SearchPage.dart';
import 'ui/view/SourceSetting/AboutPage.dart';
import 'ui/view/SourceSetting/AgentEditPage.dart';
import 'ui/view/SourceSetting/AgentSelectPage.dart';
import 'ui/view/SourceSetting/SourceEditPage.dart';
import 'ui/view/SourceSetting/SourceSettingPage.dart';
import 'ui/view/UnknownPage.dart';
import 'ui/view/homepage/HomepageTabItem.dart';
import 'ui/view/homepage/homepage.dart';
import 'ui/view/setting/HomePageTabsSetting.dart';
import 'ui/view/setting/HomepageTabItemEdit.dart';
import 'ui/view/setting/SettingPage.dart';

class MyApp extends StatelessWidget {
  MyAppController controller = new MyAppController();

//  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: "AVIS",
            theme: theme,
            routes: controller._routes,
            onGenerateRoute: controller._getRoute,
            onUnknownRoute: controller._unknowRoute,
            localizationsDelegates: [S.delegate],
            supportedLocales: S.delegate.supportedLocales,
            //todo fix chinese crash
            localeResolutionCallback:
                S.delegate.resolution(fallback: new Locale("en", "")),
//            navigatorObservers: [
//              FirebaseAnalyticsObserver(analytics: analytics),
//            ],
          );
        });
  }
}

class MyAppController extends ControllerMVC {
  final Map<String, WidgetBuilder> _routes = {
    AppRoutes.Home: (BuildContext context) => HomePage(),
    AppRoutes.Search: (BuildContext context) => SearchPage(),
    AppRoutes.About: (BuildContext context) => AboutPage(),
    AppRoutes.Backup: (BuildContext context) => BackupPage(),
    AppRoutes.SourceSetting: (BuildContext context) => SourceSettingPage(),
    AppRoutes.Donate: (BuildContext context) => DonatePage(),
    AppRoutes.Setting: (BuildContext context) => SettingPage(),
    AppRoutes.Settings_HomePageTabs: (BuildContext context) =>
        HomePageTabsSetting(),
  };

  Route<dynamic> _unknowRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => UnknownPage(settings.name),
    );
  }

  static Parse _editingParse;

  Route<dynamic> _getRoute(RouteSettings settings) {
//    if (settings.name == AppRoutes.SearchResult) {
//      final Map<String, dynamic> argv = settings.arguments;
//      return MaterialPageRoute<void>(
//        settings: settings,
//        builder: (BuildContext context) => SearchResultPage(
//            argv[AppRoutes.SearchResultArg_type],
//            argv[AppRoutes.SearchResultArg_keyword]),
//      );
//    }
//    if (settings.name == AppRoutes.MediaInfo) {
//      final Media media = settings.arguments;
//      return MaterialPageRoute<void>(
//        settings: settings,
//        builder: (BuildContext context) => MediaInfoPage(media),
//      );
//    }
    if (settings.name == AppRoutes.MediaView) {
      final Map<String, dynamic> argv = settings.arguments;
      return ViewRoute.viewRoute(
          settings,
          argv[AppRoutes.MediaViewArg_Media],
          argv[AppRoutes.MediaViewArg_EposideId],
          argv[AppRoutes.MediaViewArg_ChapterId]);
    }
    if (settings.name == AppRoutes.SourceEdit) {
      _editingParse = settings.arguments ?? BaseParse();
      return MaterialPageRoute<Parse>(
        settings: settings,
        builder: (BuildContext context) => SourceEditPage(_editingParse),
      );
    }
    if (settings.name == AppRoutes.AgentsEdit) {
      ParseAction argv = settings.arguments;
      return MaterialPageRoute<List<Agent>>(
          settings: settings,
          builder: (BuildContext context) => AgentEditPage(argv));
    }
    if (settings.name == AppRoutes.AgentSelect) {
      Agent argv = settings.arguments;
      return MaterialPageRoute<Agent>(
          settings: settings,
          builder: (BuildContext context) =>
              AgentSelectPage(argv ?? HttpAgent()));
    }
    if (settings.name == AppRoutes.AgentConfig) {
      Agent argv = settings.arguments;
      return MaterialPageRoute<Agent>(
          settings: settings,
          builder: (BuildContext context) => argv.AgentConfigPage(argv));
    }
    if (settings.name == AppRoutes.PictureView) {
      List<String> picUrls = settings.arguments;
      return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => PictureViewer(picUrls));
    }
    if (settings.name == AppRoutes.Settings_HomePageTabs_edit) {
      HomepageTabItem homepageTabItem = settings.arguments;
      return MaterialPageRoute<HomepageTabItem>(
          settings: settings,
          builder: (BuildContext context) => HomepageTabItemEdit(
                item: homepageTabItem,
              ));
    }
    return null;
  }
}
