import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Agent/common/Agent.dart';
import '../../../common/AppRoutes.dart';
import '../../../generated/i18n.dart';
import '../../../parse/common/ParseAction.dart';
import '../../../parse/common/ParseConst.dart';

class AgentEditPage extends StatefulWidget {
  final ParseAction action;

  AgentEditPage(this.action, {Key key})
      : assert(action != null),
        super(key: key);

  @override
  AgentEditPageState createState() => AgentEditPageState(this.action);
}

class AgentEditPageState extends StateMVC {
  final ParseAction action;

  AgentEditPageState(this.action) : super();

  void _removeAgent(BuildContext context, Agent agent) {
    showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Confirm Delete ${agent.name}"),
              content: Text("UUID: " + agent.uuid),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop("Cancle"),
                  child: Text("Cancle"),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop("OK"),
                  child: Text("Delete"),
                ),
              ],
            )).then((returnValue) {
      switch (returnValue) {
        case "OK":
          setState(() => action.agents.remove(agent));
          break;

        default:
          break;
      }
    });
  }

  void _addAgent(BuildContext context) {
    Navigator.of(context)
        .pushNamed<Agent>(AppRoutes.AgentSelect)
        .then((Agent agent) {
      if (agent == null) return;
      setState(() => action.agents.add(agent));
    });
  }

  Agent _editAgent(BuildContext context, Agent agent, int index) {
    Navigator.of(context)
        .pushNamed<Agent>(AppRoutes.AgentSelect, arguments: agent)
        .then((Agent agentR) {
      if (agentR == null) return;
      setState(() => action.agents[index] = agentR);
    });
  }

  void _moveAgentUP(context, index, agent) {
    if (index == 0) return;

    setState(() {
      action.agents[index] = action.agents[index - 1];
      action.agents[index - 1] = agent;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${ParseConst.ParseActionTypeStrings[action.type.index]} agents Edit"),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.save),
//            onPressed: () {},
//          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAgent(context),
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: <Widget>[]
          ..add(Container(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              color: Theme.of(context).primaryColorLight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Agent edit"),
                ],
              )))
          ..addAll(action.agents.length > 0
              ? action.agents
                  .asMap()
                  .map((index, agent) => MapEntry(
                      index,
                      ListTile(
                        title: Text(agent.name),
                        subtitle: Text(agent.uuid),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Visibility(
                              visible: index != 0,
                              child: IconButton(
                                icon: Icon(Icons.arrow_upward),
                                tooltip: "Move UP",
                                onPressed: () =>
                                    _moveAgentUP(context, index, agent),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _editAgent(context, agent, index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _removeAgent(context, agent),
                            ),
                          ],
                        ),
                      )))
                  .values
              : [ListTile(title: Text(S.of(context).No_Agent))]),
      ),
    );
  }
}
