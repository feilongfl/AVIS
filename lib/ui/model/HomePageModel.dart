import 'package:flutter/material.dart';

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

  static List<WidgetTab> widgetTabs = [
    WidgetTab("Home", icon: Icon(Icons.home), child: null),
    WidgetTab("Article", icon: Icon(Icons.account_balance_wallet), child: null),
    WidgetTab("Video", icon: Icon(Icons.video_library), child: null),
    WidgetTab("Image", icon: Icon(Icons.image), child: null),
    WidgetTab("Sound", icon: Icon(Icons.voicemail), child: null),
  ];
}
