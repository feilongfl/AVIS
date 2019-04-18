import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/HomePageModel.dart';

class HomePageController extends ControllerMVC {
  TabController tabController;

  int get displaythis => HomePageModel.count;

  bool showIcon = false;

  List<Widget> get widgetTabs => HomePageModel.widgetTabs
      .map((t) => Tab(
            text: t.text,
            icon: showIcon ? t.icon : null,
          ))
      .toList();

  List<Widget> get widgetBodys =>
      HomePageModel.widgetTabs.map((t) => t.child).toList();

  void whatever() => HomePageModel.incre();
}
