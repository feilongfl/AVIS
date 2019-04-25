import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Agent/common/Agent.dart';
import '../../Agent/common/AgentCreater.dart';
import '../../common/AppShareData.dart';
import '../widget/SettingDivideText.dart';

class AgentSelectPage extends StatefulWidget {
  final Agent agent;

  AgentSelectPage(this.agent, {Key key})
      : assert(agent != null),
        super(key: key);

  @override
  AgentSelectPageState createState() => AgentSelectPageState(agent);
}

class AgentSelectPageState extends StateMVC {
  Agent agent;

  AgentSelectPageState(this.agent) : super();

  void _saveAndPop(BuildContext context, GlobalKey<FormState> key) {
    key.currentState.save();
    Navigator.of(context).pop(this.agent);
  }

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

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
            onPressed: () => _saveAndPop(context, _formKey),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[]
                ..add(Container(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  color: Theme.of(context).primaryColorLight,
                  child: Text(
                    "Agent Select",
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
                ..add(ListTile(
                  onTap: () => Navigator.of(context)
                          .pushNamed<Agent>(AppRoutes.AgentConfig,
                              arguments: agent)
                          .then((Agent agent) {
                        if (agent != null) {
                          this.agent = agent;
                        }
                      }),
                  leading: Icon(Icons.settings),
                  title: Text(
                      "${Agent.AgentItemNames[agent.agentType.index]} Config"),
                  subtitle: Text(this.agent.UUID),
                ))
//                ..addAll(agentConfigBody[Agent.AgentConfigBody_Widgets])
              //add end
              ,
        ),
      ),
    );
  }
}
