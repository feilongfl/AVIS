import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../common/AppEnums.dart';
import '../../../../media/Media.dart';
import '../../../../parse/common/Parse.dart';
import '../../../../parse/common/ParseConst.dart';
import '../ArticleViewer.dart';
import '../ComicViewer.dart';
import '../ImageViewer.dart';
import '../VideoViewer.dart';
import 'ViewerState.dart';

class ViewerPage extends StatefulWidget {
  StateMVC Function(Media media, String eposide, String chapter)
      createStateCallBack;
  final Media media;
  final String eposide;
  final String chapter;
  final Parse parse;

  static bool singlePageMedia(Media media, Parse parse) {
    bool result = false;

    result = result ||
        parse.actions[ParseActionType.Eposide.index].agents.length == 0;
    result = result ||
        parse.actions[ParseActionType.Chapter.index].agents.length == 0;

    return result;
  }

  bool isSinglePage() => singlePageMedia(this.media, this.parse);

  ViewerPage(
      {@required this.media, this.eposide, this.chapter, this.parse, Key key})
      : assert(media != null),
        assert(parse != null),
        super(key: key) {
    switch (media.type) {
      case MediaType.Video:
        this.createStateCallBack =
            (m, e, c) => VideoViewer(media: m, eposide: e, chapter: c);
        break;

      case MediaType.Image:
        if (isSinglePage())
          this.createStateCallBack =
              (m, e, c) => ImageViewer(media: m, eposide: e, chapter: c);
        else
          this.createStateCallBack =
              (m, e, c) => ComicViewer(media: m, eposide: e, chapter: c);
        break;

      case MediaType.Article:
        if (isSinglePage())
          this.createStateCallBack = (m, e, c) =>
              SinglePageArticleViewer(media: m, eposide: e, chapter: c);
        break;

      default:
        break;
    }
    this.createStateCallBack = this.createStateCallBack ??
        (m, e, c) => ViewerState(media: m, eposide: e, chapter: c);
  }

  @override
  State<StatefulWidget> createState() =>
      createStateCallBack(media, eposide, chapter);
}
