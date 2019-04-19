import '../Agent/Agent.dart';
import '../common/AppEnums.dart';
import '../media/Media.dart';
import 'Parse.dart';

class DemoParse implements Parse {
  static String ParseUUID = "02ca4870-5718-4fde-b4b5-dce5a09ac10a";
  static String name = "DemoParse";

  static MediaType type = MediaType.Image;

  List<List<Agent>> agents = new List(ParseType.All.index);

  Future<List<Media>> doWork(ParseType type) async {
    List<Media> result = new List();

    for (int i = 0; i < 20; i++) {
      Media media = Media();
      media.info.title = "demo result ";
      media.info.cover = "https://seaside.ebb.io/615x1017.jpg";
      media.info.title += i.toString();
      result.add(media);
    }

    return result;
  }
}
