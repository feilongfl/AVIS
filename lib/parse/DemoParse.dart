import '../Agent/Agent.dart';
import '../common/AppEnums.dart';
import '../media/Media.dart';
import 'Parse.dart';

class DemoParse implements Parse {
  static String ParseUUID = "02ca4870-5718-4fde-b4b5-dce5a09ac10a";
  static String name = "DemoParse";

  static MediaType type = MediaType.Image;

  List<List<Agent>> agents = new List(ParseType.All as int);

  Future<List<Media>> doWork(ParseType type) async {
    List<Media> result;
    Media demo = Media();

    demo.info.title = "demo";

    result.addAll([demo, demo, demo, demo, demo, demo, demo, demo, demo]);

    return result;
  }
}
