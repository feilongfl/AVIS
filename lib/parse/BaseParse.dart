import 'package:uuid/uuid.dart';

import '../Agent/Agent.dart';
import '../ResultFormatter/ResultFormatter.dart';
import '../common/AppEnums.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import 'Parse.dart';

class BaseParse implements Parse {
  String ParseUUID = "76c1ae48-81b8-42e3-a868-d69cf2f2ea5d";
  String name = "BaseParse";
  String url = "";

  MediaType type;

  List<List<Agent>> agents;

//  HttpClient httpClient = new HttpClient();
  static List<List<Agent>> _agentInit() {
    List<List<Agent>> agents = List(ParseType.All.index);

    for (int i = 0; i < ParseType.All.index; i++) agents[i] = new List();

    return agents;
  }

  BaseParse(
      {this.agents,
      this.name = "New Source",
      this.type = MediaType.Article,
      this.ParseUUID}) {
    var uuid = new Uuid();
    this.ParseUUID = this.ParseUUID ?? uuid.v4();
    this.agents = this.agents ?? _agentInit();
  }

  Future<List<Media>> doSearchHome(
      ParseType type, Map<String, dynamic> data) async {
    List<Event> events = [Event(data)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
    }

    List<Media> media = ResultFormatter.ResultFromatter[type.index](events);
    return media;
  }

  Map<String, dynamic> MapData = new Map();

  Future<Media> doInfo(ParseType type, Media media) async {
    MapData[Event.MediaId] = media.info.ID;
    List<Event> events = [Event(MapData)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
    }

    return ResultFormatter.ResultFromatter[type.index](events[0], media);
  }

  Future<Media> doEpisode(ParseType type, Media media) async {
    MapData[Event.MediaId] = media.info.ID;
    List<Event> events = [Event(MapData)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
    }

    return ResultFormatter.ResultFromatter[type.index](events, media);
  }

  Future<Media> doChapter(ParseType type, Media media) async {
    MapData[Event.MediaId] = media.info.ID;
    List<Event> events = [Event(MapData)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
    }

    return ResultFormatter.ResultFromatter[type.index](events, media);
  }

  Future<List<Media>> doWork(ParseType type, dynamic data) async {
    switch (type) {
      case ParseType.homepage:
      case ParseType.Search:
        return doSearchHome(type, data);
        break;

      case ParseType.info:
        return [await doInfo(type, data)];

      case ParseType.Episode:
        return [await doEpisode(type, data)];

      case ParseType.Chapter:
        return [await doChapter(type, data)];

      default:
        break;
    }
  }
}
