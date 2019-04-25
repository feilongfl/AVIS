import '../../common/AppEnums.dart';
import '../../event/Event.dart';
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
        return RegexpAgent(RegExp(""), [Event.Title, Event.Url]);

      default:
        return BaseAgent();
    }
  }
}
