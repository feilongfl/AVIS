import '../common/AppEnums.dart';
import '../common/AppShareData.dart';
import '../media/Media.dart';
import '../parse/Parse.dart';

class ParseRunner {
  static Future<List<Media>> _SearchOne(Parse parse, String keyword) async {
    return parse.doWork(ParseType.Search);
  }

  static Future<List<Media>> Search(String keyword, MediaType type) async {
    for (Parse parse in AppShareData.AppParse[type.index]) {
      return await _SearchOne(parse, keyword);
    }
  }

  static Media Info(Parse parse, Media media) {}

  static Media Episode(Parse parse, Media media) {}

  static Media Chapter(Parse parse, Media media) {}

  static Media Source(Parse parse, Media media) {}

  static Media SourceLazy(Parse parse, Media media) {}
}
