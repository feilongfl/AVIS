import '../common/AuthorInfo.dart';

class MediaInfo {
  String title;
  String intro;
  String cover;
  String url;
  String ID;
  int index;

  MediaInfo({
    this.title = "No Title",
    this.intro,
    this.cover,
    this.url,
    this.ID,
    this.index = 0,
  });

//  Map<String, dynamic> toJson() {
//    return {
//      MediaConst.Title: this.title,
//      MediaConst.intro: this.intro,
//      MediaConst.cover: this.cover,
//      MediaConst.url: this.url,
//      MediaConst.ID: this.ID,
//    };
//  }
}

class MediaInfoFull extends MediaInfo {
  String title;
  String intro;
  String cover;
  String url;
  String ID;
  int index;
  AuthorInfo author;
  DateTime date;
  String studio;
  bool isFinished = false;
  String databaseUrl;
  String Theme; // movie theme type todo: change to enum
  int AgeLimit; // 0 = nolimit

  MediaInfoFull({
    this.title,
    this.intro,
    this.cover,
    this.url,
    this.ID,
    this.index,
    this.author,
    this.date,
    this.studio,
    this.isFinished,
    this.databaseUrl,
    this.Theme,
    this.AgeLimit = 0, // 0 = nolimit
  }) {
    this.author = this.author ?? AuthorInfo();
  }

//  Map<String, dynamic> toJson() {
//    Map<String, dynamic> jsonObj = super.toJson();
//
//    jsonObj[MediaConst.author] = this.author.toString();
//    jsonObj[MediaConst.date] = this.date.toString();
//    jsonObj[MediaConst.studio] = this.studio;
//    jsonObj[MediaConst.isFinished] = this.isFinished;
//    jsonObj[MediaConst.databaseUrl] = this.databaseUrl;
//    jsonObj[MediaConst.Theme] = this.Theme;
//    jsonObj[MediaConst.AgeLimit] = this.AgeLimit;
//
//    return jsonObj;
//  }
}
