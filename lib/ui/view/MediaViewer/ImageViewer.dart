import 'package:flutter/material.dart';

import '../../../media/Media.dart';
import 'common/ViewerState.dart';

class ImageViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  ImageViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(media.info.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(media.type.toString()),
          Text(
            media.info.title,
            style: Theme.of(context).textTheme.display1,
            textAlign: TextAlign.center,
          ),
          Divider(),
          Text(media.info.ID),
          Text(eposide ?? "no eposide"),
          Text(chapter ?? "no chapter"),
        ],
      ),
    );
  }
}
