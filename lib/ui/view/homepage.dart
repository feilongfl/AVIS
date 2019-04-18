import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/HomePageConTroller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC with TickerProviderStateMixin {
  final String title = "AVIS";
  HomePageController homePageController = new HomePageController();

  @override
  void initState() {
    super.initState();
    homePageController.tabController = new TabController(
        length: homePageController.widgetTabs.length, vsync: this);
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
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("test"), accountEmail: Text("test@test.com")),
            ListTile(
              title: Text("Ttem 1"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Item 2"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Ttem 1"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Item 2"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
