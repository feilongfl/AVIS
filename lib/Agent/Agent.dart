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
  Agent() {}

  bool checkEventIn(Event eventIn) {}

  Future<List<Event>> doRealWork(Event eventIn) async {}

  Future<List<Event>> doWork(Event eventIn) async {}

//    this.$1 = json['$1'];
  void fromJson(Map<String, dynamic> json) {}

//    data['$1'] = this.$1;
  Map<String, dynamic> toJson() {}

  @override
  String toString() {}

  void fromString(String str) {}
}
