import '../common/AppEnums.dart';
import '../common/AppShareData.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import '../parse/Parse.dart';

class ParseRunner {
  static Future<List<Media>> _SearchOne(Parse parse, String keyword) async {
    Map<String, dynamic> data = new Map();
    data[Event.SearchKeyword] = keyword;
    return parse.doWork(ParseType.Search, data);
  }

  static Future<List<Media>> Search(String keyword, MediaType type) async {
    List<Media> medias = new List();
    for (Parse parse in AppShareData.AppParse[type.index]) {
      medias.addAll(await _SearchOne(parse, keyword));
    }
    return medias;
  }

  static Future<Media> Info(Media media) async {
    return media..info.intro = "test";
  }

  static Media Episode(Parse parse, Media media) {
    return media;
  }

  static Media Chapter(Parse parse, Media media) {
    return media;
  }

  static Media Source(Parse parse, Media media) {
    return media;
  }

  static Media SourceLazy(Parse parse, Media media) {
    return media;
  }

  static MediaType HomePagesToMediaTypes(HomePages page_type) {
    switch (page_type) {
      default:
        return MediaType.Image;
    }
  }

  static Future<List<Media>> Homepage(HomePages page_type) async {
    List<Media> medias = new List();
    for (Parse parse
        in AppShareData.AppParse[HomePagesToMediaTypes(page_type).index]) {
      medias.addAll(await parse.doWork(ParseType.Search, null));
    }
    return medias;
  }
}
