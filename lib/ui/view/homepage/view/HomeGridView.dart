import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../HomepageTabItem.dart';

class HomeGridView extends StatefulWidget {
  final HomepageTabItem item;

  HomeGridView(this.item)
      : assert(item != null),
        super();

  @override
  State<StatefulWidget> createState() => HomeGridViewState(item);
}

class HomeGridViewState extends StateMVC {
  final HomepageTabItem item;

  HomeGridViewState(this.item) : super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Text("Grid View"));
  }
}
