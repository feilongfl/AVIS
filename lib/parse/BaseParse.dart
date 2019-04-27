import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../Agent/common/Agent.dart';
import '../ResultFormatter/ResultFormatter.dart';
import '../common/AppEnums.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import 'common/Parse.dart';
import 'common/ParseJsonKey.dart';

class BaseParse implements Parse {
  String ParseUUID;
  String name;
  String url;
  String comment;
  String updateUrl;
  String author;
  String author_email;
  String author_website;

  MediaType type;

  List<List<Agent>> agents;

//  HttpClient httpClient = new HttpClient();
  static List<List<Agent>> ParseAgentInit() {
    List<List<Agent>> agents = List(ParseType.All.index);

    for (int i = 0; i < ParseType.All.index; i++) agents[i] = new List();

    return agents;
  }

  BaseParse(
      {this.agents,
      this.name = "New Source",
      this.type = MediaType.Article,
      this.url = "https://feilong.home.blog",
      this.author = "feilong",
      this.author_email = "feilongphone@gmail.com",
      this.author_website = "https://feilong.home.blog",
      this.updateUrl,
      this.comment,
      this.ParseUUID}) {
    var uuid = new Uuid();
    this.ParseUUID = this.ParseUUID ?? uuid.v4();
    this.agents = this.agents ?? ParseAgentInit();
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

  Future<Media> doSource(ParseType type, Media media) async {
    MapData[Event.MediaId] = media.info.ID;
    MapData[Event.EpisodeId] = "1";
    MapData[Event.ChapterId] = "1";
    List<Event> events = [Event(MapData)];

    for (var agent in agents[type.index]) {
      events = await agent.doWork(eventsIn: events);
      print(agent.name + "  =>  " + events[0].toString());
    }

    return ResultFormatter.ResultFromatter[type.index](events, media);
  }

  Future<List<Media>> doWork(ParseType type, dynamic data) async {
    List<Media> medias;
    switch (type) {
      case ParseType.homepage:
      case ParseType.Search:
        return doSearchHome(type, data);
        break;

      case ParseType.info:
        medias = [await doInfo(type, data)];
        break;

      case ParseType.Episode:
        medias = [await doEpisode(type, data)];
        break;

      case ParseType.Chapter:
        medias = [await doChapter(type, data)];
        break;

      case ParseType.Source:
        medias = [await doSource(type, data)];
        break;

      default:
        medias = List();
        break;
    }

    medias.forEach((media) => media.type = this.type);

    return medias;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonObj = new Map();

    jsonObj[ParseJsonKey.UUID] = this.ParseUUID;
    jsonObj[ParseJsonKey.NAME] = this.name;
    jsonObj[ParseJsonKey.URL] = this.url;
    jsonObj[ParseJsonKey.COMMENT] = this.comment;
    jsonObj[ParseJsonKey.UPDATEURL] = this.updateUrl;
    jsonObj[ParseJsonKey.TYPE] = this.type.index;
    jsonObj[ParseJsonKey.AUTHOR] = this.author;
    jsonObj[ParseJsonKey.AUTHOR_EMAIL] = this.author_email;
    jsonObj[ParseJsonKey.AUTHOR_WEBSITE] = this.author_website;
    // agent
    assert(ParseType.All.index == ParseJsonKey.AGENT_JSONKEYS.length);
    for (int i = 0; i < ParseType.All.index; i++) {
      jsonObj[ParseJsonKey.AGENT_JSONKEYS[i]] = (this.agents[i] == null)
          ? null
          : this.agents[i].map((agent) => agent.toString()).toList();
    }

    return jsonObj;
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
