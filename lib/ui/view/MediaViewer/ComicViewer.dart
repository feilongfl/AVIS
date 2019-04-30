import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../../media/Media.dart';
import '../../../parse/common/ParseRunner.dart';
import '../../widget/MediaInfoTips.dart';
import 'common/ViewerState.dart';

class ComicViewer extends ViewerState {
  Media media;
  String eposide;
  String chapter;
  bool loaded = false;

  ComicViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static Future<Media> getMedias(
      BuildContext context, Media media, String eposide, String chapter) async {
    Media mediaResult = await ParseRunner.runSource(context, media,
        eposideId: eposide, chapterId: chapter);

    return mediaResult;
  }

  Future<Media> getMedia(BuildContext context,
          {String eposideId, String chapterId}) =>
      getMedias(context, this.media, eposideId ?? this.eposide,
          chapterId ?? this.chapter);

//  Future<ui.Image> getImage(String url) {
//    Completer<ui.Image> completer = new Completer<ui.Image>();
//    new AdvancedNetworkImage(
//      url,
//      useDiskCache: true,
//      cacheRule: CacheRule(maxAge: const Duration(days: 7)),
//    ).resolve(new ImageConfiguration()).addListener(
//        (ImageInfo info, bool _) => completer.complete(info.image));
//    return completer.future;
//  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      this.getMedia(context).then((m) {
        loaded = true;
        setState(() => this.media = m);
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ComicListView(
            media: media,
            eposide: eposide,
            chapter: chapter,
          ),
          MediaInfoTips(
            mediaTitle: media.info.title,
            mediaEposideTitle: media.episode
                .firstWhere((ep) => ep.info.ID == this.eposide)
                .info
                .title,
            mediaChapterTitle: media.episode
                .firstWhere((ep) => ep.info.ID == this.eposide)
                .chapter
                .firstWhere((cp) => cp.info.ID == this.chapter)
                .info
                .title,
          ),
        ],
      ),
    );
  }
}

class ComicListView extends StatefulWidget {
  Media media;
  String eposide;
  String chapter;

  VoidCallback onPageChange;
  VoidCallback onChapterChange;

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

  @override
  Widget build(BuildContext context) {
    final thisMediaSource = this
        .widget
        .media
        .episode
        .firstWhere((ep) => ep.info.ID == this.widget.eposide)
        .chapter
        .firstWhere((cp) => cp.info.ID == this.widget.chapter)
        .sources;

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) =>
          ImageCard(thisMediaSource[index].urls[0]),
      itemCount: thisMediaSource.length,
    );
  }
}

class ImageCard extends StatelessWidget {
  final String url;
  final double defaultHeight;

  ImageCard(this.url, {this.defaultHeight = 1600}) : super();

  ImageProvider _advancedNetworkImage;

  Future<ui.Image> getImage(String url) async {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    _advancedNetworkImage = AdvancedNetworkImage(
      url,
      useDiskCache: true,
      cacheRule: CacheRule(maxAge: const Duration(days: 7)),
      fallbackAssetImage: "assets/images/imageLoadFailed.jpg",
    );
    _advancedNetworkImage.resolve(new ImageConfiguration()).addListener(
        (ImageInfo info, bool _) => completer.complete(info.image));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(url.replaceAll(r"\", '')),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: defaultHeight,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        } else {
          return Container(
              height: snapshot.data.height *
                  (MediaQuery.of(context).size.width / snapshot.data.width),
              child: Image(
                image: _advancedNetworkImage,
              ));
        }
      },
    );
  }
}
