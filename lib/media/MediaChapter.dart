import 'dart:convert';

import '../common/AppEnums.dart';
import 'MediaInfo.dart';
import 'MediaSource.dart';
import 'MeidaConst.dart';

class MediaChapter {
  MediaInfo info;
  MediaType type;

  List<MediaSource> sources;

  MediaChapter({this.info, this.sources, this.type = MediaType.Image}) {
    this.info = this.info ?? MediaInfo();
    this.sources = this.sources ?? List();
  }

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
