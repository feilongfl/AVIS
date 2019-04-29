import 'package:flutter/material.dart';

import '../../../../media/Media.dart';
import '../../../widget/MediaTileView.dart';
import '../HomepageTabItem.dart';
import 'HomeViewState.dart';

class HomeTileViewState extends HomeViewState {
  final HomepageTabItem item;

  HomeTileViewState(this.item) : super(item);

//  final double imageWidthHeight = 150;

  Widget mediaViewCard(BuildContext context,
          {@required Media media, VoidCallback onTap}) =>
      MediaTileView(
        media,
        MediaQuery.of(context).size.width * 0.28,
        onTap: onTap,
      );
}
