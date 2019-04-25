import 'package:flutter/material.dart';

import '../common/AppEnums.dart';
import '../common/AppShareData.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import '../parse/common/Parse.dart';

class ParseRunner {
  static Future<List<Media>> _SearchOne(Parse parse, String keyword) async {
    Map<String, dynamic> data = new Map();
    data[Event.SearchKeyword] = keyword;
    return parse.doWork(ParseType.Search, data);
  }

  static Future<List<Media>> Search(
      BuildContext context, String keyword, MediaType type) async {
    List<Media> medias = new List();
    for (Parse parse in AppShareData.of(context).AppParse[type.index]) {
      medias.addAll(await _SearchOne(parse, keyword).then((vals) {
        vals.forEach((m) {
          m.ParseUUID = parse.ParseUUID;
        });
        return vals;
      }));
    }
    return medias;
  }

  static Parse findParse(BuildContext context, Media media) {
    for (List<Parse> appparse in AppShareData.of(context).AppParse) {
      if (appparse != null)
        for (Parse parse in appparse) {
          if (parse.ParseUUID == media.ParseUUID) return parse;
        }
    }
    return null;
  }

  static Future<Media> Info(BuildContext context, Media media) async {
    Parse parse = findParse(context, media);
    if (parse == null) return media;

    media = (await parse.doWork(ParseType.info, media))[0];

    return media;
  }

  static Future<Media> Episode(BuildContext context, Media media) async {
    Parse parse = findParse(context, media);
    if (parse == null) return media;

    media = (await parse.doWork(ParseType.Episode, media))[0];

    return media;
  }

  static Future<Media> Chapter(BuildContext context, Media media) async {
    Parse parse = findParse(context, media);
    if (parse == null) return media;
    //todo fix here
    media = (await parse.doWork(ParseType.Chapter, media))[0];

    return media;
  }

  static Media Source(Parse parse, Media media) {
    return media;
  }

  static Media SourceLazy(Parse parse, Media media) {
    return media;
  }

  static MediaType HomePagesToMediaTypes(HomePages page_type) {
    switch (page_type) {
      case HomePages.Video:
      case HomePages.Comic:
      case HomePages.Novel:
      case HomePages.Music:
        return [
          MediaType.Article,
          MediaType.Video,
          MediaType.Image,
          MediaType.Sound,
        ][page_type.index - 1];

      default:
        return MediaType.Image;
    }
  }

  static Future<List<Media>> Homepage(
      BuildContext context, HomePages page_type) async {
    List<Media> medias = new List();
    for (Parse parse in AppShareData.of(context)
        .AppParse[HomePagesToMediaTypes(page_type).index]) {
      medias.addAll(await parse.doWork(ParseType.homepage, null).then((ms) {
        ms.forEach((val) {
          val.ParseUUID = parse.ParseUUID;
        });
        return ms;
      }));
      return medias;
    }
  }
}
