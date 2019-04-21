import '../Agent/Agent.dart';
import '../ResultFormatter/ResultFormatter.dart';
import '../common/AppEnums.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import 'Parse.dart';

class BaseParse implements Parse {
  String ParseUUID = "76c1ae48-81b8-42e3-a868-d69cf2f2ea5d";
  String name = "BaseParse";

  MediaType type = MediaType.Image;

  List<List<Agent>> agents = new List(ParseType.All.index);

//  HttpClient httpClient = new HttpClient();

  BaseParse(this.agents, {this.name, this.type, this.ParseUUID});

  Future<List<Media>> doWork(ParseType type, Map<String, dynamic> data) async {
    List<Event> events = [Event(data)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
    }

    List<Media> media = ResultFormatter.ResultFromatter[type.index](events);

    return media;
  }
}
