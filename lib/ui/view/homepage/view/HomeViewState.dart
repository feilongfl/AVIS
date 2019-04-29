import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../media/Media.dart';
import '../../../widget/MediaCardView.dart';
import '../HomepageTabItem.dart';

class HomeViewState extends StateMVC {
  final HomepageTabItem item;
  List<Media> medias = List();
  GlobalKey<EasyRefreshState> easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  HomeViewState(this.item) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EasyRefresh(
          key: easyRefreshKey,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 3
                      : 2),
              itemCount: medias.length,
              itemBuilder: (BuildContext context, int index) =>
                  MediaCardView(medias[index])),
          onRefresh: () async {
            setState(() => medias.add(Media()));
          },
          loadMore: () async {
            setState(() => medias.add(Media()..info.title = "loadmore"));
          }),
    );
  }
}
