import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../../../media/Media.dart';
import '../../../widget/MediaCardView.dart';
import '../HomepageTabItem.dart';
import 'HomeViewState.dart';

class HomeGridViewState extends HomeViewState {
  final HomepageTabItem item;

  final int landCount = 3;
  final int portCount = 2;

  HomeGridViewState(this.item) : super(item);

  Widget mediaViewCard(BuildContext context,
          {@required Media media, VoidCallback onTap}) =>
      MediaCardView(
        title: media.info.title,
        cover: media.info.cover,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EasyRefresh(
        key: easyRefreshKey,
        firstRefresh: true,
        autoLoad: item.autoLoadmore,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? landCount
                        : portCount),
            itemCount: medias.length,
            itemBuilder: (BuildContext context, int index) => mediaViewCard(
                  context,
                  media: medias[index],
                  onTap: () => this.onTap(context, medias[index]),
                )),
        onRefresh: () async => await refersh(context),
        loadMore: () async => await loadMore(context),
      ),
    );
  }
}
