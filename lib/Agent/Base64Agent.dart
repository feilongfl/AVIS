import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../generated/i18n.dart';
import '../parse/event/Event.dart';
import '../ui/widget/SettingDivideText.dart';
import 'common/Agent.dart';
import 'common/AgentEnums.dart';
import 'common/AgentJsonKey.dart';
import 'common/BaseAgent.dart';

class Base64Agent extends BaseAgent {
  String name = "Base64Agent";

  String agentUUID = "ea3d1dd1-f213-4036-bab7-530f98572e75";
  AgentLists agentType = AgentLists.Base64Agent;

  String text;

  CodecAgent_Method method;

  String resultSave;

  Base64Agent({this.text, this.method, this.resultSave}) : super();

  Future<List<Event>> doRealWork(Event eventIn) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // set replace key
    switch (this.method) {
      case CodecAgent_Method.encode:
        data[resultSave] = base64
            .encode(utf8.encode(this.ReplaceOneVal(this.text, eventIn.Data)));

        break;
      case CodecAgent_Method.decode:
        data[resultSave] = utf8
            .decode(base64.decode(this.ReplaceOneVal(this.text, eventIn.Data)));
        break;

      default:
        break;
    }

    return [Event(data, SendUUID: this.agentUUID, success: true)];
  }

  @override
  Map<String, dynamic> toJson() {
    var jsonObj = super.toJson();

    jsonObj[AgentJsonKey.AgentJsonKey_CODEC_METHOD] = this.method.index;
    jsonObj[AgentJsonKey.AgentJsonKey_TEXT] = this.text;
    jsonObj[AgentJsonKey.AgentJsonKey_SAVETO] = this.resultSave;

    return jsonObj;
  }

  Widget agentConfigPage(Agent agent) => _AgentConfigPage(agent);
}

class _AgentConfigPage extends StatefulWidget {
  final Agent agent;

  _AgentConfigPage(this.agent, {Key key}) : super(key: key);

  @override
  _AgentConfigPageState createState() => _AgentConfigPageState(agent);
}

class _AgentConfigPageState extends StateMVC {
  final Base64Agent agent;
  var _formKey = GlobalKey<FormState>();

  _AgentConfigPageState(this.agent)
      : assert(agent.agentType == AgentLists.Base64Agent),
        super();

  void _saveAndPop() {
    _formKey.currentState.save();
    Navigator.of(context).pop(agent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${agent.name} ${S.of(context).Config}"),
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
              ..add(SettingDevideText(S.of(context).Base64_Config))
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                        labelText: S.of(context).Agent_Codec_Text),
                    onSaved: (v) => setState(() => agent.text = v),
                    initialValue: agent.text,
                  ),
                ),
              )
              ..add(
                ListTile(
                  title: DropdownButtonFormField<CodecAgent_Method>(
                      value: agent.method,
                      onChanged: (v) => setState(() => agent.method = v),
                      decoration: InputDecoration(
                          labelText: S.of(context).Agent_Codec_Method),
                      items: AgentConst.CodecsMethods.map((v) =>
                          DropdownMenuItem(
                              value: v,
                              child: Text(AgentConst.codecsMethodStrings(
                                  context)[v.index]))).toList()),
                ),
              )
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).Agent_SaveTo),
                    onSaved: (v) => setState(() => agent.resultSave = v),
                    initialValue: agent.resultSave,
                  ),
                ),
              )),
      ),
    );
  }
}
