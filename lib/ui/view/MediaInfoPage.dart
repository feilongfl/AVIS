import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../ParseRunner/ParseRunner.dart';
import '../../media/Media.dart';

class MediaInfoPage extends StatefulWidget {
  Media media;

  MediaInfoPage(this.media, {Key key}) : super(key: key);

  @override
  MediaInfoPageState createState() => MediaInfoPageState(this.media);
}

class MediaInfoPageState extends StateMVC {
  Media media;

  MediaInfoPageState(this.media) : super();

  Widget _mediaList(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: true,
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
      childAspectRatio: 5,
      children: ["01", "02", "03", "04", "05"]
          .map((v) => Text(
                v,
                textAlign: TextAlign.center,
              ))
          .toList(),
    );
  }

  Widget _CoverView(BuildContext context) {
    final image_width =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.width / 3
            : MediaQuery.of(context).size.width * 0.6;
    final image_height = image_width * 1.25;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
          height: image_height,
          width: image_width,
          child: Image.network(
            media.info.cover,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _MediaInfoLists(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              media.info.title,
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            Text(
              media.info.author ?? "loading author ...",
              textAlign: TextAlign.center,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                media.info.intro ?? "loading intro ...",
                textAlign: TextAlign.left,
              ),
            ),
            Divider(),
            _mediaList(context),
          ],
        ),
      ),
    );
  }

  Widget land(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _CoverView(context),
        _MediaInfoLists(context),
      ],
    );
  }

  Widget port(BuildContext context) {
    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _CoverView(context),
        _MediaInfoLists(context),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    ParseRunner.Info(media).then((m) {
      setState(() {
        this.media = m;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(media.info.title)),
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          child: MediaQuery.of(context).orientation == Orientation.landscape
              ? land(context)
              : port(context),
        ),
      ),
    );
  }
}
