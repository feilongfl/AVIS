import '../media/Media.dart';
import '../parse/Parse.dart';
import 'AppEnums.dart';

class AppShareData {
  static const String AppName = "AVIS";
  static const String defaultKeywords = "UnknowKeywords";

  static const String finishTip_isFin = "Finish";
  static const String finishTip_notFin = "not Finish";

  //Saved Media
  static List<List<Media>> Rss =
      new List(MediaType.All.index); //rss source for homepage
  static List<List<Media>> Favorite = new List(MediaType.All.index);
  static List<List<Media>> History = new List(MediaType.All.index);

  //parse config
  static List<List<Parse>> AppParse = new List(MediaType.All.index);
}

class AppRoutes {
  static const String Home = "/";
  static const String Search = "/Search";
  static const String SearchResult = "/SearchResult";
  static const String SearchResultArg_type = "type";
  static const String SearchResultArg_keyword = "keyword";
  static const String Histroy = "/History";
  static const String Favorite = "/Favorite";
  static const String Backup = "/Backup";
  static const String SourceSetting = "/SourceSetting";
  static const String Setting = "/Setting";
  static const String Donate = "/Donate";
  static const String About = "/About";
  static const String MediaInfo = "/MediaInfo";
}

class HttpUserAgent {
  static String Linux_Chrome =
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36";
}
