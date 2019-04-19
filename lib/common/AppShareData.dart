import '../media/Media.dart';
import 'AppEnums.dart';

class AppShareData {
  static const AppName = "AVIS";
  static const defaultKeywords = "UnknowKeywords";

  //Saved Media
  static List<List<Media>> Rss =
      new List(MediaType.All as int); //rss source for homepage
  static List<List<Media>> Favorite = new List(MediaType.All as int);
  static List<List<Media>> History = new List(MediaType.All as int);

//parse config

}


class AppRoutes {
  static const String Home = "/";
  static const String Search = "/Search";
  static const String SearchResult = "/SearchResult";
  static const String SearchResultArg_type = "type";
  static const String SearchResultArg_keyword = "keyword";
}
