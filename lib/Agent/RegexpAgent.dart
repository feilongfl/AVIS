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

  Widget choice(
      BuildContext context, int index, String matchGroup, StateMVC parent) {
//    return Text("$index $matchGroup");
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => parent.setState(() => matchGroups.removeAt(index)),
          )
        ],
      ),
      leading: Text("\$$index:"),
      title: DropdownButtonFormField<String>(
          value: matchGroups[index],
          onChanged: (v) => parent.setState(() => matchGroups[index] = v),
          decoration: InputDecoration(labelText: "Group:"),
          items: Event.EventItemStrings.map((v) => DropdownMenuItem<String>(
                value: v,
                child: Text(v),
              )).toList()),
    );
  }

  Map<String, dynamic> configBody(BuildContext context,
      {Object argument, Key key, StateMVC parent}) {
    return {
      Agent.AgentConfigBody_Widgets: <Widget>[]..add(Column(
        children: <Widget>[
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(labelText: "Regexp"),
              onSaved: (v) => parent.setState(() => regexp = RegExp(v)),
            ),
          ),
        ]
          ..add(SettingDevideText("Match Group"))
          ..addAll(matchGroups.length == 0
              ? [Text("Null")]
              : matchGroups
                  .asMap()
                  .map((i, m) => MapEntry(i, choice(context, i, m, parent)))
                  .values)
          ..add(ListTile(
            title: Text("Add"),
            leading: Icon(Icons.add),
            onTap: () => parent
                .setState(() => matchGroups.add(Event.EventItemStrings[0])),
          )),
      )),
    };
  }
}
