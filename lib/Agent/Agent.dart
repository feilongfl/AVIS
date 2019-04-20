import '../event/Event.dart';

class Agent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  static String name;
  static DateTime DefaultDateTime;
  String _UUID;

  DateTime lastRun;
  static String AgentUUID;

  String get UUID => _UUID;

//  this.$1,
  Agent();

  bool checkEventIn(Event eventIn) {
    return false;
  }

  Future<List<Event>> doRealWork(Event eventIn) async {
    return null;
  }

  Future<List<Event>> doWork({Event eventIn, List<Event> eventsIn}) async {
    return null;
  }

//  Future<List<Event>> doWork(List<Event> eventIn) async {}

//    this.$1 = json['$1'];
  void fromJson(Map<String, dynamic> json) {}

//    data['$1'] = this.$1;
  Map<String, dynamic> toJson() {
    return null;
  }

  @override
  String toString() {
    return null;
  }

  void fromString(String str) {}
}
