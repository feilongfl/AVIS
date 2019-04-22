import 'MediaChapter.dart';
import 'MediaInfo.dart';

class MediaEpisode {
//  int index = 0;
  MediaInfo info = MediaInfo();
  String EpisodeId = "";

  List<MediaChapter> chapter = new List();

  MediaEpisode({this.info, this.EpisodeId, this.chapter}) {
    this.chapter = this.chapter ?? new List();
  }
}
