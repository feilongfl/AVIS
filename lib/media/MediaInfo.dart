class MediaInfo{
  String title;
  String intro;
  String cover;
  String url;
  //save parse data
  String eid;
  String cid;
  String pid;
}

class MediaInfoFull extends MediaInfo{
  String author;
  DateTime date;
  String studio;
  bool isFinished;
  String databaseUrl;
}