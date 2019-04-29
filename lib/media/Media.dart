import 'dart:convert';

import '../common/AppEnums.dart';
import '../parse/common/ParseConst.dart';
import '../parse/event/Event.dart';
import 'MediaEpisode.dart';
import 'MediaInfo.dart';
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

  static List<Media> fromEvent(List<Event> events, ParseActionType actionType,
      {Media media, MediaType type, String parseUUID}) {
    List<Media> medias = List();

    switch (actionType) {
      case ParseActionType.HomePage:
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

      default:
        break;
    }

    return medias;
  }
}
