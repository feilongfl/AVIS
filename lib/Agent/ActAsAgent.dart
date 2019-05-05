import '../parse/event/Event.dart';
import 'common/AgentEnums.dart';
import 'common/BaseAgent.dart';

// Delegate event to other Parse
class ActAsAgent extends BaseAgent {
  String name = "ActAsAgent";

  String agentUUID = "f9e725e1-3435-4a9e-969c-c4418d3bfb43";
  AgentLists agentType = AgentLists.Base64Agent;

  String parseUUID = "";

  ActAsAgent({this.parseUUID}) : super();

  Future<List<Event>> doRealWork(Event eventIn) async {
    Map<String, dynamic> data = Map.from(eventIn.Data);

    // todo finish here

    return [Event(data, SendUUID: this.agentUUID, success: true)];
  }

  @override
  Map<String, dynamic> toJson() {
    var jsonObj = super.toJson();

//    jsonObj[AgentJsonKey.AgentJsonKey_CODEC_METHOD] = this.method.index;
//    jsonObj[AgentJsonKey.AgentJsonKey_TEXT] = this.text;
//    jsonObj[AgentJsonKey.AgentJsonKey_SAVETO] = this.resultSave;

    return jsonObj;
  }

//  Widget AgentConfigPage(Agent agent) => _AgentConfigPage(agent);
}
//
//class _AgentConfigPage extends StatefulWidget {
//  final Agent agent;
//
//  _AgentConfigPage(this.agent, {Key key}) : super(key: key);
//
//  @override
//  _AgentConfigPageState createState() => _AgentConfigPageState(agent);
//}
//
//class _AgentConfigPageState extends StateMVC {
//  final Base64Agent agent;
//  var _formKey = GlobalKey<FormState>();
//
//  _AgentConfigPageState(this.agent)
//      : assert(agent.agentType == AgentLists.Base64Agent),
//        super();
//
//  void _saveAndPop() {
//    _formKey.currentState.save();
//    Navigator.of(context).pop(agent);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("${agent.name} ${S.of(context).Config}"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.save),
//            onPressed: _saveAndPop,
//          )
//        ],
//      ),
//      body: Form(
//        key: _formKey,
//        child: ListView(
//            children: <Widget>[]
//              ..add(SettingDevideText(S.of(context).Base64_Config))
//              ..add(
//                ListTile(
//                  title: TextFormField(
//                    decoration: InputDecoration(
//                        labelText: S.of(context).Agent_Codec_Text),
//                    onSaved: (v) => setState(() => agent.text = v),
//                    initialValue: agent.text,
//                  ),
//                ),
//              )
//              ..add(
//                ListTile(
//                  title: DropdownButtonFormField<CodecAgent_Method>(
//                      value: agent.method,
//                      onChanged: (v) => setState(() => agent.method = v),
//                      decoration: InputDecoration(
//                          labelText: S.of(context).Agent_Codec_Method),
//                      items: AgentConst.CodecsMethods.map((v) =>
//                          DropdownMenuItem(
//                              value: v,
//                              child: Text(AgentConst.CodecsMethodStrings(
//                                  context)[v.index]))).toList()),
//                ),
//              )
//              ..add(
//                ListTile(
//                  title: TextFormField(
//                    decoration:
//                    InputDecoration(labelText: S.of(context).Agent_SaveTo),
//                    onSaved: (v) => setState(() => agent.resultSave = v),
//                    initialValue: agent.resultSave,
//                  ),
//                ),
//              )),
//      ),
//    );
//  }
//}
