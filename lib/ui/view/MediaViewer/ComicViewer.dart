import 'dart:async';
import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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

  Future<Media> getMedia(BuildContext context) =>
      getMedias(context, this.media, this.eposide, this.chapter);

  Future<ui.Image> getImage(String url) {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    new AdvancedNetworkImage(
      url,
      useDiskCache: true,
      cacheRule: CacheRule(maxAge: const Duration(days: 7)),
    ).resolve(new ImageConfiguration()).addListener(
        (ImageInfo info, bool _) => completer.complete(info.image));
    return completer.future;
  }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: !loaded
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : EasyRefresh(
                          onRefresh: () {},
                          child: ListView.builder(
                              itemCount: media.episode
                                  .firstWhere(
                                      (ep) => ep.info.ID == this.eposide)
                                  .chapter
                                  .firstWhere(
                                      (cp) => cp.info.ID == this.chapter)
                                  .sources
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                String url = media.episode
                                    .firstWhere(
                                        (ep) => ep.info.ID == this.eposide)
                                    .chapter
                                    .firstWhere(
                                        (cp) => cp.info.ID == this.chapter)
                                    .sources[index]
                                    .urls[0]
                                    .replaceAll(r'\', '');
                                return FutureBuilder(
                                    future: getImage(url),
                                    builder: (context,
                                        AsyncSnapshot<ui.Image> snapshot) {
                                      if (snapshot.hasData) {
                                        ui.Image image = snapshot.data;
                                        return Container(
                                            height: image.height *
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    image.width),
                                            child: Image(
                                                image: AdvancedNetworkImage(
                                              url,
                                              useDiskCache: true,
                                              cacheRule: CacheRule(
                                                  maxAge:
                                                      const Duration(days: 7)),
                                            )));
                                      } else {
                                        return new Text('Loading...');
                                      }
                                    });
                              }),
                        ),
                ),
              )
            ],
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
