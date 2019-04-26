import '../../common/AppEnums.dart';
import '../../event/Event.dart';
import '../EventFormatAgent.dart';
import '../HttpAgent.dart';
import '../RegexpAgent.dart';
import 'Agent.dart';
import 'BaseAgent.dart';

class AgentCreater {
  static Agent newAgent(AgentLists agentType) {
    switch (agentType) {
      case AgentLists.HttpAgent:
        return HttpAgent();

      case AgentLists.RegexpAgent:
        return RegexpAgent(matchBody: Event.Body, regexp:  RegExp(""), matchGroups: [Event.Title, Event.Url]);

      case AgentLists.EventFormatAgent:
        return EventFormatAgent(findKey: [Event.Url], Replaces: ["http://${Event.Url}"]);

      default:
        return BaseAgent();
    }
  }
}
