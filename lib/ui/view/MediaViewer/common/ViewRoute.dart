import 'package:flutter/material.dart';

import '../../../../common/AppShareData.dart';
import '../../../../media/Media.dart';
import 'ViewerPage.dart';

class ViewRoute {
  static MaterialPageRoute viewRoute(
      RouteSettings settings, Media media, String eposide, String chapter) {
    switch (media.type) {
      default:
        return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) => ViewerPage(
                  media: media,
                  eposide: eposide,
                  chapter: chapter,
                  parse: AppShareData.of(context)
                      .appParse
                      .firstWhere((p) => p.info.uuid == media.ParseUUID),
                ));
        break;
    }
  }
}
