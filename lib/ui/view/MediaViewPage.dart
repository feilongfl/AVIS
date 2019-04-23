import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../media/Media.dart';

class MediaViewPage extends StatefulWidget {
  Media media;
  String EposideId;
  String ChapterId;

  MediaViewPage(this.media, this.EposideId, this.ChapterId, {Key key})
      : super(key: key);

  @override
  MediaViewPageState createState() =>
      MediaViewPageState(this.media, this.EposideId, this.ChapterId);
}

class MediaViewPageState extends StateMVC {
  Media media;
  String EposideId;
  String ChapterId;

  MediaViewPageState(this.media, this.EposideId, this.ChapterId) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(media.info.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("mid: ${media.info.ID}"),
            Text("eid: $EposideId"),
            Text("cid: $ChapterId"),
            Text("type: ${media.type.toString()}"),
          ],
        ),
      ),
    );
  }
}
