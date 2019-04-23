import '../Agent/Agent.dart';
import '../common/AppEnums.dart';
import '../media/Media.dart';

class Parse {
  String ParseUUID;
  String name;
  String url;
  MediaType type;

  List<List<Agent>> agents;

  Future<List<Media>> doWork(ParseType type, dynamic argv) async {
    return null;
  }
}
