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
      RegExp('<a class="image-link" href="(.*?)" title="(.*?)"><img src="(.*?)" width="\\d+" height="\\d+" alt="" default="(?:.*?)">'),
      [Event.Url, Event.Title, Event.Cover]);

  agents[ParseType.Search.index] = [domoAgent, demoRegexAgent];

  return agents;
}

void initAppParse() async {
  for (int i = 0; i < MediaType.All.index; i++) {
    AppShareData.AppParse[MediaType.Image.index] = new List();
  }

  //exp agents
  List<List<Agent>> expagents = GenExpAgents();

  // for debug use
  AppShareData.AppParse[MediaType.Image.index].add(BaseParse(expagents));
  AppShareData.AppParse[MediaType.Image.index].add(BaseParse(expagents));
}

void init() {
  initAppParse();
}

void main() {
  init();
  runApp(MyApp());
}
