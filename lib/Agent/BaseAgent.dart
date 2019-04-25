import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:uuid/uuid.dart' as UuidGen;

import '../common/AppEnums.dart';
import '../event/Event.dart';
import 'Agent.dart';

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
  String _UUID = "";

  AgentLists agentType = AgentLists.All;

  DateTime lastRun = Agent.DefaultDateTime;
  final String AgentUUID =
      "36aee99f-5ce8-4726-802d-363308bb9054"; //https://www.uuidgenerator.net/

  String get UUID => _UUID;

  List<String> replaces = Event.EventItemStrings;


  //  this.$1,
  BaseAgent() {
    var uuid = new UuidGen.Uuid();
    _UUID = uuid.v4();
  }

  bool checkEventIn(Event eventIn) {
    if (eventIn != null)
      return !eventIn.success;
    else
      return true;
  }

  Widget AgentConfigPage(Agent agent) => _AgentConfigPage(agent);

  Future<List<Event>> doRealWork(Event eventIn) async {
    this.lastRun = DateTime.now();

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = "Hello world!";

    return [Event(data, SendUUID: this._UUID, success: true)];
  }

  String ReplaceOneVal(String val, Event event) {
    if (val == null) return val;
    if (event == null) return val;
    if (val == "") return val;
    if (this.replaces == null) return val;

    this.replaces.forEach((replace) {
      val = val.replaceAll(replace, event.Data[replace] ?? "");
    });
    return val;
  }

  Event ReplaceVal(Event eventIn) {
    if (this.replaces == null) return eventIn;
    if (eventIn.Data == null) return eventIn;

    eventIn.Data.forEach((key, val) {
      if (val.runtimeType == String)
        eventIn.Data[key] = ReplaceOneVal(val, eventIn);
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

  void fromJson(Map<String, dynamic> json) {
    if (AgentUUID != json['AgentUUID']) return;
//    this.$1 = json['$1'];
    this._UUID = json['UUID'];
    this.lastRun = json['lastRun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['$1'] = this.$1;
    data['UUID'] = this._UUID;
    data['lastRun'] = this.lastRun;

    return data;
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }

  void fromString(String str) {
    final Map<String, dynamic> data = json.decode(str);
    this.fromJson(data);
  }
}
