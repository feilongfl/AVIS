import 'package:flutter/material.dart';

import '../ParseRunner/ParseRunner.dart';
import '../media/Media.dart';
import 'common/ViewerState.dart';

class VideoViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  VideoViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  Future<Media> _getMedias(BuildContext context) async {
    print("get source");
    return ParseRunner.Source(context, media);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(media.info.title),
      ),
      body: FutureBuilder(
          future: _getMedias(context),
          builder: (context, snapshot) => Column(
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
              )),
    );
  }
}
