import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Agent/Agent.dart';
import '../../common/AppEnums.dart';
import '../../common/AppShareData.dart';
import '../../parse/Parse.dart';
import '../model/SourceEditPageModel.dart';

class AgentEditPage extends StatefulWidget {
  final ParseType parseType;

  AgentEditPage(this.parseType, {Key key})
      : assert(parseType != null),
        super(key: key);

  @override
  AgentEditPageState createState() => AgentEditPageState(this.parseType);
}

class AgentEditPageState extends StateMVC {
  final ParseType parseType;

  AgentEditPageState(this.parseType) : super();

  void _removeAgent(BuildContext context, Agent agent) {
    showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Confirm Delete ${agent.name}"),
              content: Text("UUID: " + agent.UUID),
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
          setState(() => SourceEditPageModel.of(context)
              .agents[parseType.index]
              .remove(agent));
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
      setState(() =>
          SourceEditPageModel.of(context).agents[parseType.index].add(agent));
    });
  }

  Agent _editAgent(BuildContext context, Agent agent, int index) {
    Navigator.of(context)
        .pushNamed<Agent>(AppRoutes.AgentSelect, arguments: agent)
        .then((Agent agentR) {
      if (agentR == null) return;
      setState(() => SourceEditPageModel.of(context).agents[parseType.index]
          [index] = agentR);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${Parse.ParseTypeStrings[parseType.index]} Agents Edit"),
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
                  Text(SourceEditPageModel.of(context).name),
                ],
              )))
          ..addAll(
              SourceEditPageModel.of(context).agents[parseType.index].length > 0
                  ? SourceEditPageModel.of(context)
                      .agents[parseType.index]
                      .asMap()
                      .map((index, agent) => MapEntry(
                          index,
                          ListTile(
                            title: Text(agent.name),
                            subtitle: Text(agent.UUID),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {},
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
                  : [ListTile(title: Text("No Agents"))]),
      ),
    );
  }
}
