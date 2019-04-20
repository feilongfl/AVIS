import 'dart:convert';

import '../event/Event.dart';
import 'Agent.dart';

class BaseAgent implements Agent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  final String name = "BaseAgent";
  static DateTime DefaultDateTime = DateTime(2010);
  String _UUID = "";

  DateTime lastRun = DefaultDateTime;
  final String AgentUUID =
      "36aee99f-5ce8-4726-802d-363308bb9054"; //https://www.uuidgenerator.net/

  String get UUID => _UUID;

  //  this.$1,
  BaseAgent() {
    _UUID = ""; // todo generate UUID here
  }

  bool checkEventIn(Event eventIn) {
    if (eventIn != null)
      return !eventIn.success;
    else
      return true;
  }

  Future<List<Event>> doRealWork(Event eventIn) async {
    this.lastRun = DateTime.now();

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = "Hello world!";

    return [Event(data, SendUUID: this._UUID, success: true)];
  }

  Future<List<Event>> _doOneWork(Event eventIn) async {
    if (this.checkEventIn(eventIn))
      return [Event(null, SendUUID: this._UUID, success: false)];

    return doRealWork(eventIn).then((v) async {
      v.forEach((vv) {
        vv.SendUUID = AgentUUID;
      });
      return v;
    });
  }

  Future<List<Event>> doWork({Event eventIn, List<Event> eventsIn}) async {
    List<Event> eventResult = new List();

    if (eventIn != null) {
      eventResult.addAll(await _doOneWork(eventIn));
    }
    if (eventsIn != null)
      for (var e in eventsIn) {
        eventResult.addAll(await _doOneWork(e));
      }

    return eventResult;
  }

  void fromJson(Map<String, dynamic> json) {
    if (AgentUUID != json['AgentUUID']) return;
//    this.$1 = json['$1'];
    this._UUID = json['UUID'];
    this.lastRun = json['lastRun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['$1'] = this.$1;
    data['UUID'] = this._UUID;
    data['lastRun'] = this.lastRun;

    return data;
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }

  void fromString(String str) {
    final Map<String, dynamic> data = json.decode(str);
    this.fromJson(data);
  }
}
