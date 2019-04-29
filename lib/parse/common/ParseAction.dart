import 'dart:convert';

import '../../Agent/common/Agent.dart';
import '../../Agent/common/AgentCreator.dart';
import '../event/Event.dart';
import 'ParseConst.dart';

class ParseAction {
  ParseActionType type;
  List<Agent> agents;

  ParseAction({this.agents, this.type = ParseActionType.Info}) {
    this.agents = this.agents ?? List();
  }

  Future<List<Event>> doWork(List<Event> events) async {
    for (var agent in agents) {
      events = await agent.doWork(eventsIn: events);
    }
    return events;
  }

  static const jsonKey_type = "type";
  static const jsonKey_agents = "agents";

  static ParseAction fromJson(Map<String, dynamic> jsonObj) {
    return ParseAction(
      type: ParseActionType.values[jsonObj[jsonKey_type]],
      agents: jsonObj[jsonKey_agents]
          .cast<String>()
          .map((as) => (AgentCreator.loadStringToAgent(as)))
          .cast<Agent>()
          .toList(),
    );
  }

  static ParseAction fromString(String str) {
    return fromJson(json.decode(str));
  }

  Map<String, dynamic> toJson() {
    return {
      jsonKey_type: type.index,
      jsonKey_agents: agents.map((a) => a.toString()).toList(),
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
