import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Agent/Agent.dart';
import '../../Agent/AgentCreater.dart';
import '../../common/AppShareData.dart';
import '../widget/SettingDivideText.dart';

class AgentConfigPage extends StatefulWidget {
  final Agent agent;

  AgentConfigPage(this.agent, {Key key})
      : assert(agent != null),
        super(key: key);

  @override
  AgentConfigPageState createState() => AgentConfigPageState(agent);
}

class AgentConfigPageState extends StateMVC {
  Agent agent;

  AgentConfigPageState(this.agent) : super();

  void _saveAndPop(BuildContext context) {
    Navigator.of(context).pop(this.agent);
  }

  @override
  Widget build(BuildContext context) {
    var agentConfigBody = agent.configBody(context, parent: this);

    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Config"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Dry Run",
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.AgentDryRun, arguments: agent),
          ),
          IconButton(
            icon: Icon(Icons.save),
            tooltip: "Save",
            onPressed: () => _saveAndPop(context),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[]
              ..add(Container(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                color: Theme.of(context).primaryColorLight,
                child: Text(
                  "Agent Config",
                  textAlign: TextAlign.center,
                ),
              ))
              ..add(SettingDevideText("Normal Config"))
              ..add(ListTile(
                title: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "Agent Type"),
                  items: Agent.AgentItems.map((t) => DropdownMenuItem(
                      value: t,
                      child: Text(
                        Agent.AgentItemNames[t.index],
                      ))).toList(),
                  value: agent.agentType,
                  onChanged: (v) =>
                      setState(() => agent = AgentCreater.newAgent(v)),
                ),
              ))
              ..add(SettingDevideText("Agent Config"))
              ..addAll(agentConfigBody[Agent.AgentConfigBody_Widgets])
            //add end
            ,
      ),
    );
  }
}
