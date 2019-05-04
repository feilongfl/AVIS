import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';

import '../../../media/Media.dart';
import '../../widget/MediaInfoTips.dart';
import 'ComicListView.dart';
import 'common/ViewerState.dart';

class ComicViewer extends ViewerState {
  Media media;
  String eposide;
  String chapter;

  ComicViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    Screen.keepOn(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ComicListView(
            media: media,
            eposide: eposide,
            chapter: chapter,
            onChapterChange: (c) => setState(() => this.chapter = c),
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
