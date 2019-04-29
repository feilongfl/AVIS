import 'package:flutter/material.dart';

import '../../../UiConst.dart';
import '../HomepageTabItem.dart';
import 'HomeGridView.dart';
import 'HomeTileView.dart';
import 'HomeViewState.dart';

class HomeView extends StatefulWidget {
  final HomepageTabItem item;

  HomeView(this.item)
      : assert(item != null),
        super();

  @override
  HomeViewState createState() {
    switch (item.viewType) {
      case ViewType.GridView:
        return HomeGridViewState(item);

      case ViewType.TileView:
        return HomeTileViewState(item);

      default:
        return HomeViewState(item);
    }
  }
}
