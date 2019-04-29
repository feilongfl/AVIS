import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../../../media/Media.dart';
import '../../../widget/MediaCardView.dart';
import '../HomepageTabItem.dart';
import 'HomeViewState.dart';

class HomeGridView extends StatefulWidget {
  final HomepageTabItem item;

  HomeGridView(this.item)
      : assert(item != null),
        super();

  @override
  HomeGridViewState createState() => HomeGridViewState(item);
}

class HomeGridViewState extends HomeViewState {
  final HomepageTabItem item;
  List<Media> medias = List();
  GlobalKey<EasyRefreshState> easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  bool firstShow = true;

  HomeGridViewState(this.item) : super(item);

  Future<void> loadMore(BuildContext context) {
    setState(() => medias.add(Media()..info.title = "loadmore"));
  }

  Future<void> refersh(BuildContext context) async {
    setState(() => medias.add(Media()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EasyRefresh(
        key: easyRefreshKey,
        firstRefresh: true,
        autoLoad: true,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 3
                        : 2),
            itemCount: medias.length,
            itemBuilder: (BuildContext context, int index) =>
                MediaCardView(medias[index])),
        onRefresh: () async => await refersh(context),
        loadMore: () async => await loadMore(context),
      ),
    );
  }
}
