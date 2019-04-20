import 'package:avis/MyApp.dart';
import 'package:flutter/material.dart';

import 'Agent/Agent.dart';
import 'Agent/HttpAgent.dart';
import 'Agent/RegexpAgent.dart';
import 'ResultFormatter/ResultFormatter.dart';
import 'common/AppEnums.dart';
import 'common/AppShareData.dart';
import 'parse/BaseParse.dart';

List<List<Agent>> GenExpAgents() {
  List<List<Agent>> agents = new List(ParseType.All.index);

  Agent domoAgent = HttpAgent("https://www.50mh.com/list/riben/");
  Agent demoRegexAgent = RegexpAgent(
      RegExp('<a class="comic_img" href="(.*?)"><img src="(.*?)" alt="(.*?)"'),
      [ResultFormatter.url, ResultFormatter.cover, ResultFormatter.title]);

  agents[ParseType.Search.index] = [domoAgent, demoRegexAgent];

  return agents;
}

void initAppParse() {
  for (int i = 0; i < MediaType.All.index; i++) {
    AppShareData.AppParse[MediaType.Image.index] = new List();
  }

  //exp agents
  List<List<Agent>> expagents = GenExpAgents();

  // for debug use
  AppShareData.AppParse[MediaType.Image.index].add(BaseParse(expagents));
}

void init() {
  initAppParse();
}

void main() {
  init();
  runApp(MyApp());
}
