import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../media/Media.dart';
import '../../../parse/common/ParseRunner.dart';
import 'common/ViewerState.dart';

class SinglePageArticleViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  SinglePageArticleViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  Future<Media> getMedia(BuildContext context) async {
    Media mediaResult = await ParseRunner.runSource(context, this.media);

    return mediaResult;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(media.info.title),
      ),
      body: FutureBuilder<Media>(
          future: getMedia(context),
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: HtmlWidget(snapshot.hasData
                    ? snapshot.data.episode[0].chapter[0].sources[0].urls[0]
                    : ""),
              ),
            );
          }),
    );
  }
}
