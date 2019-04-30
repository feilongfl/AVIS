import 'dart:convert';

import 'MediaChapter.dart';
import 'MediaInfo.dart';
import 'MeidaConst.dart';

class MediaEpisode {
//  int index = 0;
  MediaInfo info = MediaInfo();

//  String EpisodeId = "";//move to info

  List<MediaChapter> chapter = new List();

  MediaEpisode({this.info, this.chapter}) {
    this.chapter = this.chapter ?? new List();
    this.info = this.info ?? new MediaInfo();
  }

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Info: info.toString(),
      MediaConst.Chapter: chapter.map((c) => c.toString()).toList(),
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
