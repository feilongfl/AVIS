import 'dart:convert';

import '../common/AppEnums.dart';
import 'MediaInfo.dart';
import 'MediaSource.dart';
import 'MeidaConst.dart';

class MediaChapter {
  MediaInfo info;
  MediaType type = MediaType.Image;

  List<MediaSource> sources = List();

  MediaChapter({this.info, this.sources, this.type});

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Info: info.toString(),
      MediaConst.Type: type.index,
      MediaConst.Sources: sources.map((s) => s.toString()).toList(),
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
