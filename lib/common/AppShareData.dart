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
}
