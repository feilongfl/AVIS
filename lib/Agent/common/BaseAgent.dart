import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../event/Event.dart';
import 'Agent.dart';
import 'AgentJsonKey.dart';

class _AgentConfigPage extends StatefulWidget {
  final Agent agent;

  _AgentConfigPage(this.agent, {Key key}) : super(key: key);

  @override
  _AgentConfigPageState createState() => _AgentConfigPageState(agent);
}

class _AgentConfigPageState extends StateMVC {
  final Agent agent;

  _AgentConfigPageState(this.agent) : super();

  void _saveAndPop() {
    Navigator.of(context).pop(agent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${agent.name} Config"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveAndPop,
          )
        ],
      ),
      body: Form(
          child: ListView(
        children: <Widget>[]..add(ListTile(
            title: TextFormField(
              decoration: InputDecoration(labelText: "UUID"),
              initialValue: agent.UUID,
              enabled: false,
            ),
          )),
      )),
    );
  }
}

class BaseAgent implements Agent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  String name = "BaseAgent";
  String _UUID = "36aee99f-5ce8-4726-802d-363308bb9054";

  AgentLists agentType = AgentLists.All;

//  DateTime lastRun = Agent.DefaultDateTime;
  final String AgentUUID =
      "36aee99f-5ce8-4726-802d-363308bb9054"; //https://www.uuidgenerator.net/

  String get UUID => AgentUUID;

  List<String> replaces = Event.EventItemStrings;

  //  this.$1,
  BaseAgent() {
//    var uuid = new UuidGen.Uuid();
//    _UUID = AgentUUID;
  }

  bool checkEventIn(Event eventIn) {
    if (eventIn != null)
      return !eventIn.success;
    else
      return true;
  }

  Widget AgentConfigPage(Agent agent) => _AgentConfigPage(agent);

  Future<List<Event>> doRealWork(Event eventIn) async {
//    this.lastRun = DateTime.now();

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[Event.Body] = "Hello world!";

    return [Event(data, SendUUID: this._UUID, success: true)];
  }

  String ReplaceOneVal(String val, Map<String, dynamic> data) {
    if (val == null) return val;
    if (data == null) return val;
    if (val == "") return val;
    if (this.replaces == null) return val;

    this.replaces.forEach((replace) {
      val = val.replaceAll(replace, data[replace] ?? "");
    });
    return val;
  }

  Event ReplaceVal(Event eventIn) {
    if (this.replaces == null) return eventIn;
    if (eventIn.Data == null) return eventIn;

    eventIn.Data.forEach((key, val) {
      if (val.runtimeType == String)
        eventIn.Data[key] = ReplaceOneVal(val, eventIn.Data);
    });

    return eventIn;
  }

  Future<List<Event>> _doOneWork(Event eventIn) async {
    if (this.checkEventIn(eventIn))
      return [Event(null, SendUUID: this._UUID, success: false)];

    eventIn = ReplaceVal(eventIn);

    return doRealWork(eventIn).then((v) async {
      v.forEach((vv) {
        vv.SendUUID = AgentUUID;
      });
      return v;
    });
  }

  Future<List<Event>> doWork({Event eventIn, List<Event> eventsIn}) async {
    List<Event> eventResult = new List();

    if (eventIn != null) {
      eventResult.addAll(await _doOneWork(eventIn));
    }
    if (eventsIn != null)
      for (var e in eventsIn) {
        eventResult.addAll(await _doOneWork(e));
      }

    return eventResult;
  }

// static void fromJson(Map<String, dynamic> json) {
//    if(json['TYPE'])
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[AgentJsonKey.AgentJsonKey_UUID] = this.AgentUUID;
    data[AgentJsonKey.AgentJsonKey_TYPE] = this.agentType.index;

    return data;
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }

//  void fromString(String str) {
//    final Map<String, dynamic> data = json.decode(str);
//    this.fromJson(data);
//  }
}
