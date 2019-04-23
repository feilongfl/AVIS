import '../event/Event.dart';
import '../media/Media.dart';
import '../media/MediaChapter.dart';
import '../media/MediaEpisode.dart';
import '../media/MediaInfo.dart';

class ResultFormatter {
  static List<dynamic> ResultFromatter = [
    SearchEventFormat,
    InfoEventFormat,
    EpisodeEventFormat,
    ChapterEventFormat,
    SourceEventFormat,
    SourceLazyEventFormat,
    HomepageEventFormat,
    LoginEventFormat,
  ];

  static String _selectData(String priStr, String secStr, String defaultStr) {
    return priStr ?? secStr ?? defaultStr;
  }

  static Media EventToMedia(Event event, Media media) {
    Map<String, dynamic> data = event.Data;
    media = media ?? Media();
    media.info.title =
        _selectData(data[Event.Title], media.info.title, "title");
    media.info.cover =
        _selectData(data[Event.Cover], media.info.cover, "cover");
    media.info.url = _selectData(data[Event.Url], media.info.url, "url");
    media.info.ID = _selectData(data[Event.MediaId], media.info.ID, "MediaId");
    media.info.intro =
        _selectData(data[Event.Intro], media.info.intro, "eventIntro");

    return media;
  }

  static List<Media> SearchEventFormat(List<Event> events) {
    List<Media> medias = new List();
    for (var event in events) {
      medias.add(EventToMedia(event, null));
    }
    return medias;
  }

  static Media InfoEventFormat(Event event, Media media) {
    return EventToMedia(event, media);
  }

  static Media EpisodeEventFormat(List<Event> events, Media media) {
    for (Event event in events) {
      Map<String, dynamic> data = event.Data;

      MediaInfo episodeInfo = MediaInfo();
      episodeInfo.title = data[Event.Title];
      episodeInfo.ID = data[Event.EpisodeId] ?? "";
      episodeInfo.url = data[Event.Url] ?? "";

      media.episode.add(MediaEpisode(info: episodeInfo));
    }

    return media;
  }

  static Media ChapterEventFormat(List<Event> events, Media media) {
    for (Event event in events) {
      Map<String, dynamic> data = event.Data;

      MediaInfo chapterInfo = MediaInfo();
      chapterInfo.title = data[Event.Title];
      chapterInfo.ID = data[Event.ChapterId] ?? "";
      chapterInfo.url = data[Event.Url] ?? "";

      media.episode
//          .where((e) => e.info.title == data[Event.Group])
          .forEach((e) {
        e.chapter.add(MediaChapter(info: chapterInfo));
      });
    }

    return media;
    ;
  }

  static Media SourceEventFormat(Event event) {
    return null;
  }

  static Media SourceLazyEventFormat(Event event) {
    return null;
  }

  static List<Media> HomepageEventFormat(List<Event> events) {
    List<Media> medias = new List();
    for (var event in events) {
      medias.add(EventToMedia(event, null));
    }
    return medias;
  }

  static void LoginEventFormat(Event event) {}
}
