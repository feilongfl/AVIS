import 'dart:convert';

import '../common/AppEnums.dart';
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
}
