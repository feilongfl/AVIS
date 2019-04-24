import '../common/AppEnums.dart';
import 'Agent.dart';
import 'BaseAgent.dart';
import 'HttpAgent.dart';
import 'RegexpAgent.dart';

class AgentCreater {
  static Agent newAgent(AgentLists agentType) {
    switch (agentType) {
      case AgentLists.HttpAgent:
        return HttpAgent();

      case AgentLists.RegexpAgent:
        return RegexpAgent(RegExp(""), List());

      default:
        return BaseAgent();
    }
  }
}
