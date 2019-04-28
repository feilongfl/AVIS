import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../parse/event/Event.dart';
import '../ui/widget/SettingDivideText.dart';
import 'common/Agent.dart';
import 'common/AgentEnums.dart';
import 'common/AgentJsonKey.dart';
import 'common/BaseAgent.dart';

class EventFormatAgent extends BaseAgent {
  String name = "EventFormatAgent";

  String AgentUUID = "dfa1f15e-f70a-4bef-b765-3f2c064de94a";
  AgentLists agentType = AgentLists.EventFormatAgent;

  final List<String> findKey;

  final List<String> Replaces;

  EventFormatAgent({this.findKey, this.Replaces}) : super();

  Future<List<Event>> doRealWork(Event eventIn) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    //copy ori event
    eventIn.Data.forEach((key, val) {
      if (val.runtimeType == String) data[key] = eventIn.Data[key];
    });

    // set replace key
    assert(findKey.length == Replaces.length);
    for (int i = 0; i < findKey.length; i++) {
      var key = findKey[i];
      data[key] = ReplaceOneVal(Replaces[i], eventIn.Data);
    }

    return [Event(data, SendUUID: this.AgentUUID, success: true)];
  }

  @override
  Map<String, dynamic> toJson() {
    var jsonObj = super.toJson();

    jsonObj[AgentJsonKey.AgentJsonKey_FindKey] = this.findKey;
    jsonObj[AgentJsonKey.AgentJsonKey_REPLACETO] = this.Replaces;

    return jsonObj;
  }

  Widget AgentConfigPage(Agent agent) => _AgentConfigPage(agent);
}

class _AgentConfigPage extends StatefulWidget {
  final Agent agent;

  _AgentConfigPage(this.agent, {Key key}) : super(key: key);

  @override
  _AgentConfigPageState createState() => _AgentConfigPageState(agent);
}

class _AgentConfigPageState extends StateMVC {
  final EventFormatAgent agent;
  var _formKey = GlobalKey<FormState>();

  _AgentConfigPageState(this.agent)
      : assert(agent.agentType == AgentLists.EventFormatAgent),
        super();

  void _saveAndPop() {
    _formKey.currentState.save();
    Navigator.of(context).pop(agent);
  }

  Widget choice(BuildContext context, int index, String matchGroup) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => setState(() => agent.findKey.removeAt(index)),
          )
        ],
      ),
      leading: Text("\$$index:"),
      title: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: DropdownButtonFormField<String>(
                value: agent.findKey[index],
                onChanged: (v) => setState(() => agent.findKey[index] = v),
                decoration: InputDecoration(labelText: "Key:"),
                items:
                    Event.EventItemStrings.map((v) => DropdownMenuItem<String>(
                          value: v,
                          child: Text(v),
                        )).toList()),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(labelText: "Replaces"),
              onSaved: (v) => setState(() => agent.Replaces[index] = v),
              initialValue: agent.Replaces[index],
            ),
          ),
        ],
      ),
    );
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
        key: _formKey,
        child: ListView(
            children: <Widget>[]
//              ..add(SettingDevideText("Base Regexp"))
//              ..add(
//                ListTile(
//                  title: TextFormField(
//                    decoration: InputDecoration(labelText: "Regexp"),
//                    onSaved: (v) => setState(() => agent.regexp = RegExp(v)),
//                    initialValue: agent.regexp.pattern,
//                  ),
//                ),
//              )
              ..add(SettingDevideText("Match Group"))
              ..addAll(agent.findKey.length == 0
                  ? [Text("Null")]
                  : agent.findKey
                      .asMap()
                      .map((i, m) => MapEntry(i, choice(context, i, m)))
                      .values)
              ..add(
                ListTile(
                  title: Text("Add"),
                  leading: Icon(Icons.add),
                  onTap: () => setState(() {
                        agent.findKey.add(Event.EventItemStrings[0]);
                        agent.Replaces.add("");
                      }),
                ),
              )),
      ),
    );
  }
}
