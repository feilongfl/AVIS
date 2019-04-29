import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import '../../../common/AppRoutes.dart';
import '../../../common/AppShareData.dart';
import '../../../generated/i18n.dart';
import '../../controller/HomePageConTroller.dart';
import '../../widget/RouteButton.dart';
import 'view/HomeView.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC with TickerProviderStateMixin {
  HomePageController homePageController = new HomePageController();

  List<RouteButton> drawerRouteLists(BuildContext context) {
    return [
      RouteButton(
          name: S.of(context).History,
          icon: Icons.history,
          route: AppRoutes.Histroy),
      RouteButton(
          name: S.of(context).Favorite,
          icon: Icons.favorite,
          route: AppRoutes.Favorite),
      RouteButton(
          name: S.of(context).Download,
          icon: Icons.file_download,
          route: AppRoutes.Download),
      RouteButton(devide: true),
      RouteButton(
          name: S.of(context).Backup,
          icon: Icons.backup,
          route: AppRoutes.Backup),
      RouteButton(
          name: S.of(context).Source_Settings,
          icon: Icons.settings_input_component,
          route: AppRoutes.SourceSetting),
      RouteButton(
          name: S.of(context).Settings,
          icon: Icons.settings,
          route: AppRoutes.Setting),
      RouteButton(devide: true),
      RouteButton(
          name: S.of(context).Donate,
          icon: Icons.attach_money,
          route: AppRoutes.Donate),
      RouteButton(
          name: S.of(context).About,
          icon: Icons.account_box,
          route: AppRoutes.About),
    ];
  }

  int _tabLength = 1;

  @override
  void initState() {
    super.initState();
    homePageController.tabController =
        new TabController(length: _tabLength, vsync: this);
  }

  List<Widget> drawerLists(BuildContext context) {
    //todo replace here
    final String username = "feilong";
    final String email = "feilongphone@gmail.com";
    final gravatar = Gravatar(email);

    return <Widget>[
      UserAccountsDrawerHeader(
          accountName: Text(username),
          currentAccountPicture: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              child: Image(
                  image: AdvancedNetworkImage(
                gravatar.imageUrl(
                  size: 100,
                  defaultImage: GravatarImage.retro,
                  rating: GravatarRating.pg,
                  fileExtension: true,
                ),
                useDiskCache: true,
                cacheRule: CacheRule(maxAge: const Duration(days: 7)),
              )),
            ),
          ),
          accountEmail: Text(email)),
    ]..addAll(drawerRouteLists(context)
        .map((v) => (v.devide ?? false)
            ? Divider()
            : ListTile(
                title: Text(v.name),
                trailing: Icon(v.icon),
                onTap: () => v.nav(context),
              ))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    if (_tabLength != AppShareData.of(context).homepageTabItems.length + 1) {
      _tabLength = AppShareData.of(context).homepageTabItems.length + 1;
      homePageController.tabController =
          new TabController(length: _tabLength, vsync: this);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AppName),
        bottom: TabBar(
          isScrollable: true,
          controller: homePageController.tabController,
          tabs: [
            Tab(
              text: "Home",
            )
          ]..addAll(AppShareData.of(context).homepageTabItems.map((h) => Tab(
                text: h.name,
              ))),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(DynamicTheme.of(context).brightness == Brightness.dark
                ? FontAwesomeIcons.sun
                : FontAwesomeIcons.moon),
            onPressed: () => DynamicTheme.of(context).setBrightness(
                (DynamicTheme.of(context).brightness == Brightness.dark)
                    ? Brightness.light
                    : Brightness.dark),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () => homePageController.doSearch(context),
          )
        ],
      ),
      body: TabBarView(
          controller: homePageController.tabController,
          children: [
            // main page
            Center(
              child: Icon(Icons.home),
            )
          ]..addAll(AppShareData.of(context)
              .homepageTabItems
              .map((h) => HomeView(h))
              .toList())),
      drawer: Drawer(
        child: ListView(
          children: drawerLists(context),
        ),
      ),
    );
  }
}
