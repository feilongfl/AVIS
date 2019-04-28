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
      {Media media}) {
    // todo complete here
    return List();
  }
}
