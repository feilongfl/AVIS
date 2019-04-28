import 'package:flutter/material.dart';

import '../../common/AppEnums.dart';
import '../../common/AppShareData.dart';
import '../../media/Media.dart';
import '../event/Event.dart';
import 'Parse.dart';
import 'ParseConst.dart';

class ParseRunner {
  static Future<List<Media>> run(
    BuildContext context,
    ParseType parseType,
    ParseActionType actionType, {
    Media media,
    MediaType mediaType = MediaType.All,
    String mediaId,
    String eposideId,
    String chapterId,
    String sourcePath,
    String keyword,
  }) async {
    List<Media> medias = new List();

    // trig event
    final Map<String, dynamic> data = {
      Event.MediaId: mediaId,
      Event.EpisodeId: eposideId,
      Event.ChapterId: chapterId,
      Event.SourcePath: sourcePath,
      Event.SearchKeyword: keyword,
    };

    //pre parse
    final List<Parse> parses = (media.ParseUUID == null)
        ? AppShareData.of(context)
            .AppParse
            .where((p) => p.type == parseType)
            .toList()
        : AppShareData.of(context)
            .AppParse
            .where((p) => p.info.uuid == media.ParseUUID)
            .toList();

    // run
    if (parseType == ParseType.Source)
      for (Parse p in parses) {
        medias.addAll(Media.fromEvent(
            await p.doWork(actionType, [Event(data)]), actionType,
            media: media));
      }

    return medias;
  }
}
