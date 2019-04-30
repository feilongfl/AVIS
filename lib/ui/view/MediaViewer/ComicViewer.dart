import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../media/Media.dart';
import '../../widget/MediaInfoTips.dart';
import 'common/ViewerState.dart';

class ComicViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  ComicViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(media.info.title),
//      ),
      body: Stack(
        children: <Widget>[
          Column(
//            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
//                width: 300,
//                height: 300,
                  color: Colors.pink,
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
