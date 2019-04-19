class MediaInfo{
  String title = "media";
  String intro= "intro";
  String cover = "https://seaside.ebb.io/615x1017.jpg";
  String url = "";
  //save parse data
  String eid = "";
  String cid = "";
  String pid = "";
}

class MediaInfoFull extends MediaInfo{
  String author = "feilong";
  DateTime date = DateTime.now();
  String studio = "";
  bool isFinished = false;
  String databaseUrl = "";
}