import 'dart:convert';

import '../../common/AppEnums.dart';
import '../../event/Event.dart';
import '../Base64Agent.dart';
import '../EventFormatAgent.dart';
import '../HttpAgent.dart';
import '../RegexpAgent.dart';
import '../UrlCodecsAgent.dart';
import 'Agent.dart';
import 'AgentEnums.dart';
import 'AgentJsonKey.dart';
import 'BaseAgent.dart';

class AgentCreator {
  static Agent loadStringToAgent(String str) {
    var jsonObj = json.decode(str);
    return loadAgent(jsonObj);
  }

  static Agent newAgent(AgentLists agentType) {
    switch (agentType) {
      case AgentLists.HttpAgent:
        return HttpAgent();

      case AgentLists.RegexpAgent:
        return RegexpAgent(
            matchBody: Event.Body,
            regexp: RegExp(""),
            matchGroups: [Event.Title, Event.Url]);

      case AgentLists.EventFormatAgent:
        return EventFormatAgent(
            findKey: [Event.Url], Replaces: ["http://${Event.Url}"]);

      case AgentLists.Base64Agent:
        return Base64Agent(
            text: "",
            method: CodecAgent_Method.decode,
            resultSave: Event.TempVal1);

      case AgentLists.UrlCodecsAgent:
        return UrlCodecsAgent(
            text: "",
            method: CodecAgent_Method.decode,
            resultSave: Event.TempVal1);

      default:
        return BaseAgent();
    }
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

      case AgentLists.Base64Agent:
        return Base64Agent(
            text: jsonObj[AgentJsonKey.AgentJsonKey_TEXT],
            method: CodecAgent_Method
                .values[jsonObj[AgentJsonKey.AgentJsonKey_CODEC_METHOD]],
            resultSave: jsonObj[AgentJsonKey.AgentJsonKey_SAVETO]);
        break;

      case AgentLists.UrlCodecsAgent:
        return UrlCodecsAgent(
            text: jsonObj[AgentJsonKey.AgentJsonKey_TEXT],
            method: CodecAgent_Method
                .values[jsonObj[AgentJsonKey.AgentJsonKey_CODEC_METHOD]],
            resultSave: jsonObj[AgentJsonKey.AgentJsonKey_SAVETO]);
        break;

      default:
        return BaseAgent();
        break;
    }
  }
}
