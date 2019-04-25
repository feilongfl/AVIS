import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../media/Media.dart';
import 'ViewerState.dart';

class ViewerPage extends StatefulWidget {
  StateMVC Function(Media media, String eposide, String chapter)
      createStateCallBack;
  final Media media;
  final String eposide;
  final String chapter;

  ViewerPage({@required this.media, this.eposide, this.chapter, Key key})
      : assert(media != null),
        super(key: key) {
    switch (media.type) {
      default:
        this.createStateCallBack =
            (m, e, c) => ViewerState(media: m, eposide: e, chapter: c);
        break;
    }
  }

  @override
  State<StatefulWidget> createState() =>
      createStateCallBack(media, eposide, chapter);
}