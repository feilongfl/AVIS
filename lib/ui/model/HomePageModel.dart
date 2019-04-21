import 'package:flutter/material.dart';

import '../../common/AppEnums.dart';
import '../view/HomepageBody.dart';

class WidgetTab {
  String text;
  Icon icon;
  Widget child;

  WidgetTab(this.text, {this.icon, this.child}) {
    if (this.child == null) {
      this.child = SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon == null ? Icon(Icons.texture) : icon,
              Text(text),
            ],
          ),
        ),
      );
    }
  }
}

class HomePageModel {
  static int _counter = 0;

  static int get count => _counter;

  static int incre() => _counter++;

  static String title = "Media Center";

  static List<WidgetTab> widgetTabs = [
    WidgetTab("Home",
        icon: Icon(Icons.home), child: HomepageBody(HomePages.Home)),
    WidgetTab("Novel",
        icon: Icon(Icons.account_balance_wallet),
        child: HomepageBody(HomePages.Novel)),
    WidgetTab("Video",
        icon: Icon(Icons.video_library), child: HomepageBody(HomePages.Video)),
    WidgetTab("Comic",
        icon: Icon(Icons.image), child: HomepageBody(HomePages.Comic)),
    WidgetTab("Music",
        icon: Icon(Icons.voicemail), child: HomepageBody(HomePages.Music)),
  ];
}
