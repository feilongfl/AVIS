import 'dart:convert';

import '../../Agent/common/Agent.dart';
import '../../Agent/common/AgentCreator.dart';
import '../../common/AppEnums.dart';
import '../BaseParse.dart';
import 'Parse.dart';
import 'ParseJsonKey.dart';

class ParseCreator {
  static Parse fromJson(Map<String, dynamic> jsonObj) {
    List<List<Agent>> agents = BaseParse.ParseAgentInit();

    assert(ParseType.All.index == ParseJsonKey.AGENT_JSONKEYS.length);
    for (int i = 0; i < ParseType.All.index; i++) {
      final List<dynamic> agentsStrs = jsonObj[ParseJsonKey.AGENT_JSONKEYS[i]];
      agents[i] = agentsStrs == null
          ? List()
          : agentsStrs
              .map((agentstr) => AgentCreator.loadStringToAgent(agentstr))
              .toList();
    }

    return BaseParse(
      type: MediaType.values[jsonObj[ParseJsonKey.TYPE]],
      ParseUUID: jsonObj[ParseJsonKey.UUID],
      name: jsonObj[ParseJsonKey.NAME],
      url: jsonObj[ParseJsonKey.URL],
      comment: jsonObj[ParseJsonKey.COMMENT],
      updateUrl: jsonObj[ParseJsonKey.UPDATEURL],
      author: jsonObj[ParseJsonKey.AUTHOR],
      author_email: jsonObj[ParseJsonKey.AUTHOR_EMAIL],
      author_website: jsonObj[ParseJsonKey.AUTHOR_WEBSITE],
      agents: agents,
    );
  }

  static Parse fromString(String str) {
    return fromJson(json.decode(str));
  }
}
