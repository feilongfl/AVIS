import 'package:flutter/material.dart';

import '../../parse/event/Event.dart';
import 'AgentEnums.dart';

abstract class Agent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  String name;

//  static DateTime DefaultDateTime = DateTime(2010);
  String _uuid;
  AgentLists agentType;

//  DateTime lastRun;
  static String agentUUID;

  String get uuid => _uuid;

//  this.$1,
  Agent();

  bool checkEventIn(Event eventIn);

  Future<List<Event>> doRealWork(Event eventIn);

  Future<List<Event>> doWork({Event eventIn, List<Event> eventsIn});

  Widget agentConfigPage(Agent agent);

//    data['$1'] = this.$1;
  Map<String, dynamic> toJson();

  @override
  String toString();

//  void fromString(String str) {}

}
