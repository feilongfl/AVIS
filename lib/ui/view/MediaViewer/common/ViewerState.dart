import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../media/Media.dart';

class ViewerState extends StateMVC {
  final Media media;
  final String eposide;
  final String chapter;

  ViewerState({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super();

  Future<Media> _getMedias(BuildContext context) async {
    print("get source");
//    return ParseRunner.Source(context, media);
    return Media();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Viewer"),
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
