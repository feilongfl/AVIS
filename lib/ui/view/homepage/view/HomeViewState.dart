import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../media/Media.dart';
import '../../../../parse/common/ParseRunner.dart';
import '../HomepageTabItem.dart';

class HomeViewState extends StateMVC {
  final HomepageTabItem item;
  List<Media> medias = List();
  GlobalKey<EasyRefreshState> easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  int loadTimes = 0;

//  final int landCount = 3;
//  final int portCount = 2;

  HomeViewState(this.item) : super();

  Future<void> loadMore(BuildContext context) async {
    loadTimes++;
    List<Media> media =
        await ParseRunner.runHomepageTab(context, item.parseUuids, loadTimes);

    setState(() => medias.addAll(media));
  }

  Future<void> refersh(BuildContext context) async {
    loadTimes = 0;
    List<Media> media =
        await ParseRunner.runHomepageTab(context, item.parseUuids, loadTimes);

    setState(() => medias = media);
  }

  Widget mediaViewCard(BuildContext context, Media media) => Text(
        media.info.title,
        textAlign: TextAlign.center,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EasyRefresh(
        key: easyRefreshKey,
        firstRefresh: true,
        autoLoad: item.autoLoadmore,
        child: ListView.builder(
            itemCount: medias.length,
            itemBuilder: (BuildContext context, int index) =>
                mediaViewCard(context, medias[index])),
        onRefresh: () async => await refersh(context),
        loadMore: () async => await loadMore(context),
      ),
    );
  }
}
