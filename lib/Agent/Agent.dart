import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../common/AppEnums.dart';
import '../event/Event.dart';

class Agent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  String name;
  static DateTime DefaultDateTime = DateTime(2010);
  String _UUID;
  AgentLists agentType;

  DateTime lastRun;
  static String AgentUUID;

  String get UUID => _UUID;

//  this.$1,
  Agent();

  bool checkEventIn(Event eventIn) => false;

  Future<List<Event>> doRealWork(Event eventIn) async => null;

  Future<List<Event>> doWork({Event eventIn, List<Event> eventsIn}) async =>
      null;

  static const String AgentConfigBody_Widgets = "widgets";

  Map<String, dynamic> configBody(BuildContext context,
          {Object argument, Key key, StateMVC parent}) =>
      {
        AgentConfigBody_Widgets: [Text("agent config")]
      };

//  Future<List<Event>> doWork(List<Event> eventIn) async {}

//    this.$1 = json['$1'];
  void fromJson(Map<String, dynamic> json) {}

//    data['$1'] = this.$1;
  Map<String, dynamic> toJson() => null;

  @override
  String toString() => null;

  void fromString(String str) {}

  static const List<AgentLists> AgentItems = [
    AgentLists.HttpAgent,
    AgentLists.RegexpAgent
  ];
  static const List<String> AgentItemNames = ["Http Agent", "Regexp Agent"];
}
