import 'dart:convert';

enum EventItems {
  //Parse arg
  Action,
  PageNums,
  // formatter event
  Title,
  Cover,
  Url,
  Body,
  Referer,
  Useragent,
  Cookies,
  HttpMethod,
  SearchKeyword,
  MediaId,
  ChapterId,
  Intro,
  EpisodeId,
  SourcePath,
  Group,
  //temp vals
  TempVal1,
  TempVal2,
  TempVal3,
  TempVal4,
  TempVal5,
  TempVal6,
  TempVal7,
  TempVal8,
  TempVal9,
}

class Event {
  DateTime Time;
  String SendUUID;

//  String RecvUUID;
  Map<String, dynamic> Data = new Map();
  bool success = true;

  //const strings
  static const String Action = "{{Action}}";
  static const String PageNums = "{{PageNums}}";
  static const String Title = "{{title}}";
  static const String Cover = "{{cover}}";
  static const String Url = "{{url}}";
  static const String Body = "{{body}}";
  static const String Referer = "{{referer}}";
  static const String Useragent = "{{useragent}}";
  static const String Cookies = "{{cookies}}";
  static const String HttpMethod = "{{httpmethod}}";
  static const String SearchKeyword = "{{searchkeyword}}";
  static const String MediaId = "{{mediaid}}";
  static const String ChapterId = "{{chapterid}}";
  static const String Intro = "{{intro}}";
  static const String EpisodeId = "{{episodeid}}";
  static const String SourcePath = "{{SourcePath}}";
  static const String Group = "{{group}}";

  // temp vals
  static const String TempVal1 = "{{TempVal1}}";
  static const String TempVal2 = "{{TempVal2}}";
  static const String TempVal3 = "{{TempVal3}}";
  static const String TempVal4 = "{{TempVal4}}";
  static const String TempVal5 = "{{TempVal5}}";
  static const String TempVal6 = "{{TempVal6}}";
  static const String TempVal7 = "{{TempVal7}}";
  static const String TempVal8 = "{{TempVal8}}";
  static const String TempVal9 = "{{TempVal9}}";

  static const List<String> EventItemStrings = [
    //parse
    Action,
    PageNums,
    //formatter
    Title,
    Cover,
    Url,
    Body,
    Referer,
    Useragent,
    Cookies,
    HttpMethod,
    SearchKeyword,
    MediaId,
    ChapterId,
    Intro,
    EpisodeId,
    SourcePath,
    Group,
    // temp vals
    TempVal1,
    TempVal2,
    TempVal3,
    TempVal4,
    TempVal5,
    TempVal6,
    TempVal7,
    TempVal8,
    TempVal9,
  ];

  Event(this.Data,
      {this.success,
//    this.RecvUUID,
      this.SendUUID}) {
    this.Time = DateTime.now();
    this.success = this.success ?? true;
    this.Data = this.Data ?? new Map();
  }

  Map<String, dynamic> toJson() {
    Data['time'] = this.Time.toString();

    return Data;
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
