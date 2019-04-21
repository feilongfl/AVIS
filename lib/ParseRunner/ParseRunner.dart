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

  static Media Info(Parse parse, Media media) {
    return null;
  }

  static Media Episode(Parse parse, Media media) {
    return null;
  }

  static Media Chapter(Parse parse, Media media) {
    return null;
  }

  static Media Source(Parse parse, Media media) {
    return null;
  }

  static Media SourceLazy(Parse parse, Media media) {
    return null;
  }
}
