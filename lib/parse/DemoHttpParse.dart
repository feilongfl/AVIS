import 'dart:io';

import '../Agent/Agent.dart';
import '../ResultFormatter/ResultFormatter.dart';
import '../common/AppEnums.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import 'Parse.dart';

class DemoHttpParse implements Parse {
  static String ParseUUID = "76c1ae48-81b8-42e3-a868-d69cf2f2ea5d";
  static String name = "DemoHttpParse";

  static MediaType type = MediaType.Image;

  List<List<Agent>> agents = new List(ParseType.All.index);

  HttpClient httpClient = new HttpClient();

  DemoHttpParse(this.agents);

  Future<List<Media>> doWork(ParseType type, Map<String, dynamic> data) async {
    List<Event> events = [Event(data)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
    }

    List<Media> media = ResultFormatter.ResultFromatter[type.index](events);

    return media;
  }
}
