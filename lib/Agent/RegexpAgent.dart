import '../event/Event.dart';
import 'BaseAgent.dart';

class RegexpAgent extends BaseAgent {
  static String name = "HttpAgent";
  static String AgentUUID = "88ae4496-76cd-4c2d-a2e0-0955a391c97e";

  String _UUID = "";
  DateTime lastRun = BaseAgent.DefaultDateTime;

  String get UUID => _UUID;

  RegExp regexp;

  RegexpAgent() : super() ;

  @override //match eventIn.body
  Future<List<Event>> doRealWork(Event eventIn) async {
    if (this.checkEventIn(eventIn))
      return [Event(null, SendUUID: this._UUID, success: false)];

    this.lastRun = DateTime.now();

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = regexp.firstMatch(eventIn.Data['body']);

    return [Event(data, SendUUID: this._UUID, success: true)];
  }
}
