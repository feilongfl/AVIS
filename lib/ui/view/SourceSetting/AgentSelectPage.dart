import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Agent/common/Agent.dart';
import '../../../Agent/common/AgentCreator.dart';
import '../../../Agent/common/AgentEnums.dart';
import '../../../common/AppRoutes.dart';
import '../../../generated/i18n.dart';
import '../../widget/SettingDivideText.dart';

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
        title: Text(S.of(context).Agent_Config),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: S.of(context).Dry_Run,
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.AgentDryRun, arguments: agent),
          ),
          IconButton(
            icon: Icon(Icons.save),
            tooltip: S.of(context).Save,
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
                    S.of(context).Agent_Select,
                    textAlign: TextAlign.center,
                  ),
                ))
                ..add(SettingDevideText(S.of(context).Normal_Config))
                ..add(ListTile(
                  title: DropdownButtonFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).Agent_Type),
                    items: AgentConst.AgentItems.map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(
                          AgentConst.AgentItemNames[t.index],
                        ))).toList(),
                    value: agent.agentType,
                    onChanged: (v) =>
                        setState(() => agent = AgentCreator.newAgent(v)),
                  ),
                ))
                ..add(SettingDevideText(S.of(context).Agent_Config))
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
                      "${AgentConst.AgentItemNames[agent.agentType.index]} ${S.of(context).Config}"),
                  subtitle: Text(this.agent.uuid),
                ))
//                ..addAll(agentConfigBody[Agent.AgentConfigBody_Widgets])
              //add end
              ,
        ),
      ),
    );
  }
}
