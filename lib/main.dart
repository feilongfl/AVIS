import 'package:avis/MyApp.dart';
import 'package:flutter/material.dart';

import 'Agent/Agent.dart';
import 'Agent/HttpAgent.dart';
import 'Agent/RegexpAgent.dart';
import 'common/AppEnums.dart';
import 'common/AppShareData.dart';
import 'event/Event.dart';
import 'parse/BaseParse.dart';

List<List<Agent>> GenExpAgents() {
  List<List<Agent>> agents = new List(ParseType.All.index);

  Agent domoAgent = HttpAgent(
      url: "https://www.50mh.com/search/?keywords=" + Event.SearchKeyword,
      replaces: [Event.SearchKeyword]);
  Agent demoRegexAgent = RegexpAgent(
      RegExp(
          r'<a class="image-link" href="(https.*?manhua\/(.*?)\/?)" title="(.*?)"><img src="(.*?)" width="\d+" height="\d+" alt="" default="(?:.*?)">'),
      [Event.Url, Event.MediaId, Event.Title, Event.Cover]);

  Agent domohAgent = HttpAgent(url: "https://www.50mh.com/list/riben/");
  Agent demohRegexAgent = RegexpAgent(
      RegExp(
          '<a class="comic_img" href="(http.*?manhua\\/(.*?)\\/)"><img src="(.*?)" alt="(.*?)"'),
      [Event.Url, Event.MediaId, Event.Cover, Event.Title]);

  Agent domoinfoAgent = HttpAgent(
      url: "https://www.50mh.com/manhua/${Event.MediaId}/",
      replaces: [Event.MediaId]);
  Agent demoinfoRegexAgent = RegexpAgent(
      RegExp(r'<meta name="description" content="(.*?)">'), [Event.Intro]);

  Agent domoepiinfoAgent = HttpAgent(
      url: "https://www.50mh.com/manhua/${Event.MediaId}/",
      replaces: [Event.MediaId]);
  Agent demoepiinfoRegexAgent =
      RegexpAgent(RegExp(r'<em class="c_3">(.*?)列表<\/em>'), [Event.Title]);

  agents[ParseType.homepage.index] = [domohAgent, demohRegexAgent];
  agents[ParseType.Search.index] = [domoAgent, demoRegexAgent];
  agents[ParseType.info.index] = [domoinfoAgent, demoinfoRegexAgent];
  agents[ParseType.Episode.index] = [domoepiinfoAgent, demoepiinfoRegexAgent];

  return agents;
}

void initAppParse() async {
  for (int i = 0; i < MediaType.All.index; i++) {
    AppShareData.AppParse[MediaType.Image.index] = new List();
  }

  //exp agents
  List<List<Agent>> expagents = GenExpAgents();

  // for debug use
  AppShareData.AppParse[MediaType.Image.index]
      .add(BaseParse(expagents, ParseUUID: "testuuid"));
}

void init() {
  initAppParse();
}

void main() {
  init();
  runApp(MyApp());
}
