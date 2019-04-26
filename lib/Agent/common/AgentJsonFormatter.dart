import 'dart:convert';

import '../../common/AppEnums.dart';
import '../EventFormatAgent.dart';
import '../HttpAgent.dart';
import '../RegexpAgent.dart';
import 'Agent.dart';
import 'AgentJsonKey.dart';
import 'BaseAgent.dart';

class AgentJsonFormatter {
  static Agent loadStringToAgent(String str) {
    var jsonObj = json.decode(str);
    return loadAgent(jsonObj);
  }

  // load Agent
  static Agent loadAgent(Map<String, dynamic> jsonObj) {
    AgentLists agentType =
        AgentLists.values[jsonObj[AgentJsonKey.AgentJsonKey_TYPE]];
    switch (agentType) {
      case AgentLists.HttpAgent:
        return HttpAgent(
          url: jsonObj[AgentJsonKey.AgentJsonKey_URL],
          method: HttpMethod.values[jsonObj[AgentJsonKey.AgentJsonKey_METHOD]],
          postData: jsonObj[AgentJsonKey.AgentJsonKey_POSTDATA],
          referer: jsonObj[AgentJsonKey.AgentJsonKey_REFERER],
          cookies: jsonObj[AgentJsonKey.AgentJsonKey_COOKIES],
          userAgent: jsonObj[AgentJsonKey.AgentJsonKey_USERAGENT],
        );
        break;

      case AgentLists.RegexpAgent:
        return RegexpAgent(
            matchBody: jsonObj[AgentJsonKey.AgentJsonKey_MATCHBODY],
            regexp: RegExp(jsonObj[AgentJsonKey.AgentJsonKey_REGEXP]),
            matchGroups:
                jsonObj[AgentJsonKey.AgentJsonKey_MATCHGROUP].cast<String>());
        break;

      case AgentLists.EventFormatAgent:
        return EventFormatAgent(
            findKey: jsonObj[AgentJsonKey.AgentJsonKey_FindKey].cast<String>(),
            Replaces:
                jsonObj[AgentJsonKey.AgentJsonKey_REPLACETO].cast<String>());
        break;

      default:
        return BaseAgent();
        break;
    }
  }
}
