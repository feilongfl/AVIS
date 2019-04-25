import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import '../../common/AppRoutes.dart';
import '../controller/HomePageConTroller.dart';
import '../widget/RouteButton.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC with TickerProviderStateMixin {
  final String title = "AVIS";
  HomePageController homePageController = new HomePageController();

  final List<RouteButton> drawerRouteLists = [
    RouteButton(name: "History", icon: Icons.history, route: AppRoutes.Histroy),
    RouteButton(
        name: "Favorite", icon: Icons.favorite, route: AppRoutes.Favorite),
    RouteButton(devide: true),
    RouteButton(name: "Backup", icon: Icons.backup, route: AppRoutes.Backup),
    RouteButton(
        name: "Source Settings",
        icon: Icons.settings_input_component,
        route: AppRoutes.SourceSetting),
    RouteButton(
        name: "Settings", icon: Icons.settings, route: AppRoutes.Setting),
    RouteButton(devide: true),
    RouteButton(
        name: "Donate", icon: Icons.attach_money, route: AppRoutes.Donate),
    RouteButton(name: "About", icon: Icons.account_box, route: AppRoutes.About),
  ];

  @override
  void initState() {
    super.initState();
    homePageController.tabController = new TabController(
        length: homePageController.widgetTabs.length, vsync: this);
  }

  List<Widget> DrawerLists(BuildContext context) {
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
    ]..addAll(drawerRouteLists
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
    return Scaffold(
      appBar: AppBar(
        title: Text(homePageController.title),
        bottom: TabBar(
          isScrollable: true,
          controller: homePageController.tabController,
          tabs: homePageController.widgetTabs,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => homePageController.doSearch(context),
          )
        ],
      ),
      body: TabBarView(
          controller: homePageController.tabController,
          children: homePageController.widgetBodys),
      drawer: Drawer(
        child: ListView(
          children: DrawerLists(context),
        ),
      ),
    );
  }
}
