import 'package:flutter/material.dart';

import '../../common/AppEnums.dart';
import '../../common/AppShareData.dart';
import '../../media/Media.dart';
import '../event/Event.dart';
import 'Parse.dart';
import 'ParseConst.dart';

class ParseRunner {
  static findParse(BuildContext context, Media media) {
    try {
      return AppShareData.of(context)
          .appParse
          .firstWhere((p) => media.ParseUUID == p.info.uuid);
    } catch (e) {
      print("Media Parse UUID not found => ${media.ParseUUID}");
      return null;
    }
  }

  static Future<List<Media>> runHomepageTab(
      BuildContext context, List<String> parseUuids, int loadTime) async {
//    loadTime = 0;// for debug ui
    if (loadTime >= parseUuids.length) return List(0);

    List<Media> medias = new List();

    String parseUuid = parseUuids[loadTime];
    medias.addAll(await run(context, ParseType.Source, ParseActionType.HomePage,
        parseUuid: parseUuid));

    return medias;
  }

  static Future<List<Media>> run(
    BuildContext context,
    ParseType parseType,
    ParseActionType actionType, {
    String parseUuid,
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

    // set uuid
    parseUuid = parseUuid ?? media.ParseUUID;

    //pre parse
    final List<Parse> parses = (parseUuid == null)
        ? AppShareData.of(context)
            .appParse
            .where((p) => p.type == parseType)
            .toList()
        : AppShareData.of(context)
            .appParse
            .where((p) => p.info.uuid == parseUuid)
            .toList();

    // run
    if (parseType == ParseType.Source)
      for (Parse p in parses) {
        medias.addAll(Media.fromEvent(
            await p.doWork(actionType, [Event(data)]), actionType,
            media: media, parseUUID: p.info.uuid, type: p.mediaType));
      }

    return medias;
  }
}
