import '../media/Media.dart';
import 'AppEnums.dart';

class AppShareData{
  //Saved Media
  static List<List<Media>> Rss = new List(MediaType.All as int);//rss source for homepage
  static List<List<Media>> Favorite = new List(MediaType.All as int);
  static List<List<Media>> History = new List(MediaType.All as int);

  //parse config


}