import 'MeidaConst.dart';

class MediaInfo {
  String title = "media";
  String intro = "intro";
  String cover = "https://seaside.ebb.io/615x1017.jpg";
  String url = "";
  String ID = "";
  int index = 0;

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Title: this.title,
      MediaConst.intro: this.intro,
      MediaConst.cover: this.cover,
      MediaConst.url: this.url,
      MediaConst.ID: this.ID,
    };
  }
}

class MediaInfoFull extends MediaInfo {
  String author = "feilong";
  DateTime date = DateTime.now();
  String studio = "";
  bool isFinished = false;
  String databaseUrl = "";
  String Theme = ""; // movie theme type todo: change to enum
  int AgeLimit = 0; // 0 = nolimit

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonObj = super.toJson();

    jsonObj[MediaConst.author] = this.author;
    jsonObj[MediaConst.date] = this.date.toString();
    jsonObj[MediaConst.studio] = this.studio;
    jsonObj[MediaConst.isFinished] = this.isFinished;
    jsonObj[MediaConst.databaseUrl] = this.databaseUrl;
    jsonObj[MediaConst.Theme] = this.Theme;
    jsonObj[MediaConst.AgeLimit] = this.AgeLimit;

    return jsonObj;
  }
}
