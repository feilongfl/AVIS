import 'dart:convert';

class Event {
  DateTime Time;
  String SendUUID;

//  String RecvUUID;
  Map<String, dynamic> Data;
  bool success = true;

  //const strings
  static const String Title = "title";
  static const String Cover = "cover";
  static const String Url = "url";
  static const String Body = "body";
  static const String Referer = "referer";
  static const String Useragent = "useragent";
  static const String Cookies = "cookies";
  static const String HttpMethod = "httpmethod";


  Event(this.Data,
      {this.success,
//    this.RecvUUID,
      this.SendUUID}) {
    this.Time = DateTime.now();
    this.success = this.success ?? true;
  }

  @override
  String toString() {
    Data['time'] = this.Time;
//    Data['send'] = this.SendUUID;
//    Data['recv'] = this.RecvUUID;

    return json.encode(Data);
  }
}
