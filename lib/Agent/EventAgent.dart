import '../event/Event.dart';
import 'BaseAgent.dart';

class EventAgent extends BaseAgent {
  final String name = "HttpAgent";
  String _UUID = "";
  DateTime lastRun = BaseAgent.DefaultDateTime;
  final String AgentUUID = "c25fa4e7-1b9f-44d0-a841-07f6112981c4";

  String get UUID => _UUID;

  List<String> replaces;

  EventAgent(this.replaces) : super();

  @override
  Future<List<Event>> doRealWork(Event eventIn) async {
    List<Event> eventOut = await super.doRealWork(eventIn);

    eventIn.Data.forEach((key, val) {
      this.replaces.forEach((replace) {
        if (val.runtimeType == String)
          eventOut[0].Data[key] =
              (val as String).replaceAll(replace, eventIn.Data[replace] ?? "");
      });
    });

    return eventOut;
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    if (AgentUUID != json['AgentUUID']) return;

    this._UUID = json['UUID'];
    this.lastRun = json['lastRun'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['UUID'] = this.UUID;
    data['lastRun'] = this.lastRun;

    return data;
  }
}
