import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../common/AppEnums.dart';
import '../event/Event.dart';
import '../ui/widget/SettingDivideText.dart';
import 'Agent.dart';
import 'BaseAgent.dart';

class RegexpAgent extends BaseAgent {
  String name = "RegexAgent";
  final String AgentUUID = "88ae4496-76cd-4c2d-a2e0-0955a391c97e";

  final AgentLists agentType = AgentLists.RegexpAgent;

//  String _UUID = "";
  DateTime lastRun = Agent.DefaultDateTime;

  String get UUID => AgentUUID;

  RegExp regexp;
  List<String> matchGroups = new List();

  List<String> replaces = new List();

  RegexpAgent(this.regexp, this.matchGroups, {this.replaces}) : super();

  @override //match eventIn.body
  Future<List<Event>> doRealWork(Event eventIn) async {
    if (this.checkEventIn(eventIn))
      return [Event(null, SendUUID: this.UUID, success: false)];

    this.lastRun = DateTime.now();

    String matchBody = eventIn.Data[Event.Body];
    List<Event> eventResult = new List();
    Iterable<Match> matcher = regexp.allMatches(matchBody);

    for (Match m in matcher) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      int i = 1;
      for (String matchGroup in matchGroups) {
        data[matchGroup] = m.group(i++);
      }
      eventResult.add(Event(data, success: true, SendUUID: this.UUID));
    }

//    return [Event(data, SendUUID: this._UUID, success: true)];
    return eventResult;
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
  final RegexpAgent agent;
  var _formKey = GlobalKey<FormState>();

  _AgentConfigPageState(this.agent) : super();

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
            onPressed: () => setState(() => agent.matchGroups.removeAt(index)),
          )
        ],
      ),
      leading: Text("\$$index:"),
      title: DropdownButtonFormField<String>(
          value: agent.matchGroups[index],
          onChanged: (v) => setState(() => agent.matchGroups[index] = v),
          decoration: InputDecoration(labelText: "Group:"),
          items: Event.EventItemStrings.map((v) => DropdownMenuItem<String>(
                value: v,
                child: Text(v),
              )).toList()),
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
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: "Regexp"),
                    onSaved: (v) => setState(() => agent.regexp = RegExp(v)),
                    initialValue: agent.regexp.pattern,
                  ),
                ),
              )
              ..add(SettingDevideText("Match Group"))
              ..addAll(agent.matchGroups.length == 0
                  ? [Text("Null")]
                  : agent.matchGroups
                      .asMap()
                      .map((i, m) => MapEntry(i, choice(context, i, m)))
                      .values)
              ..add(
                ListTile(
                  title: Text("Add"),
                  leading: Icon(Icons.add),
                  onTap: () => setState(
                      () => agent.matchGroups.add(Event.EventItemStrings[0])),
                ),
              )),
      ),
    );
  }
}
