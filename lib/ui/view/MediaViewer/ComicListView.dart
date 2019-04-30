import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../../media/Media.dart';
import '../../../media/MediaSource.dart';
import '../../../parse/common/ParseRunner.dart';
import '../../widget/ImageCard.dart';

class ComicListView extends StatefulWidget {
  Media media;
  String eposide;
  String chapter;

  void Function(String pageNum) onPageChange;
  void Function(String chapterNum) onChapterChange;

//  VoidCallback onEposideChange;

  ComicListView(
      {this.media,
      this.eposide,
      this.chapter,
      this.onPageChange,
      this.onChapterChange})
      : assert(media != null),
        super();

  @override
  State<StatefulWidget> createState() => ComicListViewState();
}

class ComicListViewState extends State<ComicListView> {
  ScrollController scrollController = ScrollController();
  bool loaded = false;
  List<MediaSource> sources = List();

  ComicListViewState() : super();

  static Future<Media> getMedias(
      BuildContext context, Media media, String eposide, String chapter) async {
    Media mediaResult = await ParseRunner.runSource(context, media,
        eposideId: eposide, chapterId: chapter);

    return mediaResult;
  }

  Future<Media> getMedia(BuildContext context,
          {String eposideId, String chapterId}) =>
      getMedias(context, this.widget.media, eposideId ?? this.widget.eposide,
          chapterId ?? this.widget.chapter);

  Future _loadMore() async {
    final _cIndex = this
        .widget
        .media
        .episode
        .firstWhere((ep) => ep.info.ID == this.widget.eposide)
        .chapter
        .indexWhere((cp) => cp.info.ID == this.widget.chapter);
    final _cLength = this
        .widget
        .media
        .episode
        .firstWhere((ep) => ep.info.ID == this.widget.eposide)
        .chapter
        .length;

    if (_cIndex + 1 < _cLength) {
      this.widget.chapter = this
          .widget
          .media
          .episode
          .firstWhere((ep) => ep.info.ID == this.widget.eposide)
          .chapter[_cIndex + 1]
          .info
          .ID;

      final mr = await getMedia(context);
      setState(() => sources.addAll(mr.episode
          .firstWhere((ep) => ep.info.ID == this.widget.eposide)
          .chapter[_cIndex + 1]
          .sources));

      this.widget.onChapterChange(mr.episode
          .firstWhere((ep) => ep.info.ID == this.widget.eposide)
          .chapter[_cIndex + 1]
          .info
          .ID);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      this.getMedia(context).then((m) {
        loaded = true;
        sources.addAll(m.episode
            .firstWhere((ep) => ep.info.ID == this.widget.eposide)
            .chapter
            .firstWhere((cp) => cp.info.ID == this.widget.chapter)
            .sources);
        setState(() => this.widget.media = m);
      });
    }

    return EasyRefresh(
      loadMore: _loadMore,
      autoLoad: true,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: sources.length,
        itemBuilder: (context, index) => ImageCard(sources[index].urls[0]),
      ),
    );
  }
}
