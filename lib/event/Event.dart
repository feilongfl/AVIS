import 'dart:convert';

class Event {
  DateTime Time;
  String SendUUID;

//  String RecvUUID;
  Map<String, dynamic> Data = new Map();
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
  static const String SearchKeyword = "\$searchkeyword";
  static const String MediaId = "\$mediaid";
  static const String ChapterId = "\$chapterid";
  static const String Intro = "intro";
  static const String EpisodeId = "\$episodeid";
  static const String Group = "group";

  Event(this.Data,
      {this.success,
//    this.RecvUUID,
      this.SendUUID}) {
    this.Time = DateTime.now();
    this.success = this.success ?? true;
    this.Data = this.Data ?? new Map();
  }

  @override
  String toString() {
    Data['time'] = this.Time;
//    Data['send'] = this.SendUUID;
//    Data['recv'] = this.RecvUUID;

    return json.encode(Data);
  }
}
