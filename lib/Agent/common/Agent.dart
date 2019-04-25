import 'package:flutter/material.dart';

import '../../common/AppEnums.dart';
import '../../event/Event.dart';

abstract class Agent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  String name;

//  static DateTime DefaultDateTime = DateTime(2010);
  String _UUID;
  AgentLists agentType;

//  DateTime lastRun;
  static String AgentUUID;

  String get UUID => _UUID;

//  this.$1,
  Agent();

  bool checkEventIn(Event eventIn);

  Future<List<Event>> doRealWork(Event eventIn);

  Future<List<Event>> doWork({Event eventIn, List<Event> eventsIn});

  Widget AgentConfigPage(Agent agent);

//    data['$1'] = this.$1;
  Map<String, dynamic> toJson();

  @override
  String toString();

//  void fromString(String str) {}

  static const List<AgentLists> AgentItems = [
    AgentLists.HttpAgent,
    AgentLists.RegexpAgent
  ];
  static const List<String> AgentItemNames = ["Http Agent", "Regexp Agent"];
}
