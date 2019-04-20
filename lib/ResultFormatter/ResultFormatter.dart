//import '../parse/Parse.dart';

import '../event/Event.dart';
import '../media/Media.dart';

class ResultFormatter {
  static const String title = "title";
  static const String cover = "cover";
  static const String url = "url";
  static const String body = "body";

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

  static List<Media> SearchEventFormat(List<Event> events) {
    List<Media> medias = new List();
    for (var event in events) {
      Map<String, dynamic> data = event.Data;
      Media media = Media();
      media.info.title = data[title];
      media.info.cover = data[cover];
      media.info.url = data[url];
      medias.add(media);
    }
    return medias;
  }

  static Media InfoEventFormat(Event event) {}

  static Media EpisodeEventFormat(Event event) {}

  static Media ChapterEventFormat(Event event) {}

  static Media SourceEventFormat(Event event) {}

  static Media SourceLazyEventFormat(Event event) {}

  static List<Media> HomepageEventFormat(List<Event> events) {}

  static void LoginEventFormat(Event event) {}
}
