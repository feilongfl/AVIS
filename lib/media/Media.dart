import 'dart:convert';

import '../common/AppEnums.dart';
import '../parse/common/Parse.dart';
import '../parse/common/ParseConst.dart';
import '../parse/event/Event.dart';
import 'MediaChapter.dart';
import 'MediaEpisode.dart';
import 'MediaInfo.dart';
import 'MediaSource.dart';
import 'MeidaConst.dart';

class Media {
  MediaInfoFull info = new MediaInfoFull();
  MediaType type = MediaType.All;
  String ParseUUID = "";

  List<MediaEpisode> episode = new List();

  Media(
      {this.info,
      this.type = MediaType.Article,
      this.ParseUUID,
      this.episode}) {
    this.info = this.info ?? MediaInfo();
    this.episode = this.episode ?? List();
  }

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Info: info.toString(),
      MediaConst.ParseUUID: ParseUUID,
      MediaConst.Type: type.index,
      MediaConst.Eposide: episode.map((e) => e.toString()).toList()
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }

  static bool checkSinglePage(Parse parse) {
    bool result = false;

    result = result ||
        parse.actions[ParseActionType.Chapter.index].agents.length == 0;
    result = result ||
        parse.actions[ParseActionType.Eposide.index].agents.length == 0;

    return result;
  }

  static List<Media> fromEvent(List<Event> events, ParseActionType actionType,
      {Media media,
      MediaType type,
      String parseUUID,
      String eposideId,
      String chapterId,
      Parse parse}) {
    List<Media> medias = List();

    switch (actionType) {
      case ParseActionType.HomePage:
      case ParseActionType.Search:
        for (Event e in events) {
          Media media = Media(
              info: MediaInfoFull(
                title: e.Data[Event.Title],
                cover: e.Data[Event.Cover],
                url: e.Data[Event.Url],
                ID: e.Data[Event.MediaId],
                intro: e.Data[Event.Intro],
//              todo add more
//               isFinished: e.Data[Event.],
              ),
              ParseUUID: parseUUID,
              type: type);

          medias.add(media);
        }
        break;

      case ParseActionType.Info:
        assert(media != null);
        final Event e = events[0];
        media.info.intro = e.Data[Event.Intro];
        //              todo add more
        medias.add(media);
        break;

      case ParseActionType.Source:
        assert(media != null);
        assert(parse != null);
        //no eposide or chapter
//        if (media.episode.length == 0) {
        if (checkSinglePage(parse)) {
          final Event e = events[0];

          media.episode.add(MediaEpisode());
          media.episode[0].chapter.add(MediaChapter());
          media.episode[0].chapter[0].sources.add(MediaSource(
            urls: [e.Data[Event.Body]],
            header: [
              {
                MediaConst.Referer: e.Data[Event.Referer],
//                MediaConst.Cookies: e.Data[Event.Cookies],
              }
            ],
          ));
        } else {
          // have eposide and chapter
          assert(eposideId != null);
          assert(chapterId != null);

          media.episode
              .firstWhere((ep) => ep.info.ID == eposideId)
              .chapter
              .firstWhere((cp) => cp.info.ID == chapterId)
              .sources = List();

          for (Event e in events) {
            try {
              media.episode
                  .firstWhere((ep) => ep.info.ID == eposideId)
                  .chapter
                  .firstWhere((cp) => cp.info.ID == chapterId)
                  .sources
                  .add(MediaSource(
                    urls: [e.Data[Event.Url]],
                    header: [
                      {
                        MediaConst.Referer: e.Data[Event.Referer],
//                        MediaConst.Cookies: e.Data[Event.Cookies],
                      }
                    ],
                  ));
            } catch (ex) {
              print("ep[$eposideId] cp[$chapterId] not match!");
            }
          }
        }

        medias.add(media);
        break;

      case ParseActionType.Eposide:
        assert(media != null);
        media.episode.clear();
        for (Event e in events) {
          if (e.Data[Event.EpisodeId] != null) {
            // have eposide
            media.episode.add(MediaEpisode()
              ..info = MediaInfo(
                title: e.Data[Event.Title] ?? e.Data[Event.EpisodeId],
                ID: e.Data[Event.EpisodeId],
                url: e.Data[Event.Url],
              ));
          }
        }

        medias.add(media);
        break;

      case ParseActionType.Chapter:
        assert(media != null);
        //add eposide if not exist
        if (media.episode.length == 0) {
          media.episode.add(MediaEpisode(info: MediaInfo(ID: "")));
        } else {
          // clear if eposide exist
          for (var ep in media.episode) {
            ep.chapter.clear();
          }
        }

        for (Event e in events) {
          if (e.Data[Event.EpisodeId] != null) {
            // have eposide
            try {
              media.episode
                  .firstWhere((ep) => ep.info.ID == e.Data[Event.EpisodeId])
                  .chapter
                  .add(MediaChapter()
                    ..info = MediaInfo(
                      title: e.Data[Event.Title] ?? e.Data[Event.ChapterId],
                      ID: e.Data[Event.ChapterId],
                      url: e.Data[Event.Url],
                    ));
            } catch (ex) {
              if (media.episode[0].info.ID == null) {
                media.episode[0].info.ID = e.Data[Event.EpisodeId];
                media.episode[0].info.title = e.Data[Event.EpisodeId];
                media.episode[0].chapter.add(MediaChapter()
                  ..info = MediaInfo(
                    title: e.Data[Event.Title] ?? e.Data[Event.ChapterId],
                    ID: e.Data[Event.ChapterId],
                    url: e.Data[Event.Url],
                  ));
              } else {
                media.episode.add(MediaEpisode(
                    info: MediaInfo(
                        ID: e.Data[Event.EpisodeId],
                        title: e.Data[Event.EpisodeId]),
                    chapter: List()
                      ..add(MediaChapter()
                        ..info = MediaInfo(
                          title: e.Data[Event.Title] ?? e.Data[Event.ChapterId],
                          ID: e.Data[Event.ChapterId],
                          url: e.Data[Event.Url],
                        ))));
              }
            }
          } else {
            //no eposide id
            media.episode[0].chapter.add(MediaChapter()
              ..info = MediaInfo(
                title: e.Data[Event.Title] ?? e.Data[Event.ChapterId],
                ID: e.Data[Event.ChapterId],
                url: e.Data[Event.Url],
              ));
          }
        }

        medias.add(media);
        break;

      default:
        break;
    }

    return medias;
  }
}
