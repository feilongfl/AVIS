import '../common/AppEnums.dart';
import '../event/Event.dart';
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
}
