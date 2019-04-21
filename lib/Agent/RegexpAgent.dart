import '../event/Event.dart';
import 'BaseAgent.dart';

class RegexpAgent extends BaseAgent {
  final String name = "HttpAgent";
  final String AgentUUID = "88ae4496-76cd-4c2d-a2e0-0955a391c97e";

  String _UUID = "";
  DateTime lastRun = BaseAgent.DefaultDateTime;

  String get UUID => _UUID;

  RegExp regexp;
  List<String> matchGroups = new List();

  List<String> replaces = new List();

  RegexpAgent(this.regexp, this.matchGroups, {this.replaces}) : super();

  @override //match eventIn.body
  Future<List<Event>> doRealWork(Event eventIn) async {
    if (this.checkEventIn(eventIn))
      return [Event(null, SendUUID: this._UUID, success: false)];

    this.lastRun = DateTime.now();

    String matchBody = eventIn.Data[Event.Body];
    List<Event> eventResult = new List();
    Iterable<Match> matcher = regexp.allMatches(matchBody);

    for (Match m in matcher) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      int i = 1;
      for (String matchGroup in matchGroups) {
        data[matchGroup] = m.group(i++);
      }
      eventResult.add(Event(data, success: true, SendUUID: this.UUID));
    }

//    return [Event(data, SendUUID: this._UUID, success: true)];
    return eventResult;
  }
}
