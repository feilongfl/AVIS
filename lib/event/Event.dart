import 'dart:convert';

class Event {
  DateTime Time;
  String SendUUID;
  String RecvUUID;
  Map<String, dynamic> Data;
  bool success = true;

  Event(this.Data, {this.success, this.RecvUUID, this.SendUUID}) {
    this.Time = DateTime.now();
  }

  @override
  String toString() {
    Data['time'] = this.Time;
    Data['send'] = this.SendUUID;
    Data['recv'] = this.RecvUUID;

    return json.encode(Data);
  }
}
