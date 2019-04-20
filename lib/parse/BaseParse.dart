import '../Agent/Agent.dart';
import '../common/AppEnums.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import 'Parse.dart';


class BaseParse implements Parse {
  static String ParseUUID = "2b898e9b-4519-4542-804f-ac2064489a70";
  static String name = "BaseParse";

  List<List<Agent>> agents = new List(ParseType.All as int);

  Future<List<Media>> doWork(ParseType type, Map<String, dynamic> argv) async {
    List<Agent> parseAgent = agents[type as int];
    List<Media> result;
    List<Event> event = new List();
    event.add(Event(null));

    for (var agent in parseAgent) {
      while (event.length != 0)
        for (var e in event) {
          event.addAll(await agent.doWork(eventIn: e));
          event.remove(e);
        }
    }

    return result;
  }
}
