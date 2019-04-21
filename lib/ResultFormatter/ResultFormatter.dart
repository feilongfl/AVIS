//import '../parse/Parse.dart';

import '../event/Event.dart';
import '../media/Media.dart';

class ResultFormatter {
//  static const String title = "title";
//  static const String cover = "cover";
//  static const String url = "url";
//  static const String body = "body";

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
    media.info.MediaId =
        _selectData(data[Event.MediaId], media.info.MediaId, "MediaId");
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

  static Media EpisodeEventFormat(Event event) {
    return null;
  }

  static Media ChapterEventFormat(Event event) {
    return null;
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
