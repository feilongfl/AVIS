import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../media/Media.dart';
import '../parse/BaseParse.dart';
import '../parse/common/Parse.dart';
import '../parse/event/Event.dart';
import 'AppEnums.dart';

//List<List<Agent>> _GenExpAgents() {
//  List<List<Agent>> agents = new List(ParseType.All.index);
//
//  Agent domoAgent = HttpAgent(
//    url: "https://www.50mh.com/search/?keywords=" + Event.SearchKeyword,
//  );
//  Agent demoRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(
//          r'<a class="image-link" href="(https.*?manhua\/(.*?)\/?)" title="(.*?)"><img src="(.*?)" width="\d+" height="\d+" alt="" default="(?:.*?)">'),
//      matchGroups: [Event.Url, Event.MediaId, Event.Title, Event.Cover]);
//
//  Agent domohAgent = HttpAgent(url: "https://www.50mh.com/list/riben/");
//  Agent demohRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(
//          '<a class="comic_img" href="(http.*?manhua\\/(.*?)\\/)"><img src="(.*?)" alt="(.*?)"'),
//      matchGroups: [Event.Url, Event.MediaId, Event.Cover, Event.Title]);
//
//  Agent domoinfoAgent = HttpAgent(
//    url: "https://www.50mh.com/manhua/${Event.MediaId}/",
//  );
//  Agent demoinfoRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(r'<meta name="description" content="(.*?)">'),
//      matchGroups: [Event.Intro]);
//
//  Agent demoepiinfoRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(r'<em class="c_3">(.*?)列表<\/em>'),
//      matchGroups: [Event.Title]);
//
//  Agent democpiinfoRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(r'<li>\s+<a href="(.*\/(\d+).*?)" title="(.*?)"'),
//      matchGroups: [Event.Url, Event.ChapterId, Event.Title]);
//
//  agents[ParseType.homepage.index] = [
//    domohAgent,
//    demohRegexAgent,
//  ];
//
//  agents[ParseType.Search.index] = [domoAgent, demoRegexAgent];
//  agents[ParseType.info.index] = [domoinfoAgent, demoinfoRegexAgent];
//  agents[ParseType.Episode.index] = [domoinfoAgent, demoepiinfoRegexAgent];
//  agents[ParseType.Chapter.index] = [domoinfoAgent, democpiinfoRegexAgent];
//
//  return agents;
//}
//
//List<List<Agent>> _GenAIXIA() {
//  List<List<Agent>> agents = new List(ParseType.All.index);
//
//  Agent domohAgent = HttpAgent(
//      url:
//          "https://m.qidian.com/category/detail?catId=21&subCatId=8&gender=male");
//  Agent demohRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(
//          r'<a href="(.*\/(\d+))" class="book-layout">\s+<img src="(?:.*?)" data-src="(.*?)" class="book-cover" alt="(.*?)">\s+<div class="book-cell">\s+<div class="book-title-x">\s+<div class="book-title-r">\s+<\/div>\s+<h4 class="book-title">(?:.*?)<\/h4>\s+<\/div>\s+<p class="book-desc"> (.*?)<\/p>'),
//      matchGroups: [
//        Event.Url,
//        Event.MediaId,
//        Event.Cover,
//        Event.Title,
//        Event.Intro
//      ]);
//
//  Agent domohformatAgent = EventFormatAgent(
//      findKey: [Event.Cover], Replaces: ["http:${Event.Cover}"]);
//
//  agents[ParseType.homepage.index] = [
//    domohAgent,
//    demohRegexAgent,
//    domohformatAgent
//  ];
//
//  return agents;
//}
//
//List<List<Agent>> _Genzzzanime() {
//  List<List<Agent>> agents = new List(ParseType.All.index);
//
//  Agent domohAgent = HttpAgent(url: "http://www.zzzfun.com/map-index.html");
//  Agent demohRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(
//          r'<a href="(\/vod-detail-id-(\d+)\.html)" style="\s+color: #fffee4;\s+">(.*?)<\/a><em>\/<\/em><\/h5>\s+<div class="tipInfo">\s+<div class="play-img"><img src="(.*?)" alt="(?:.*?)" \/>'),
//      matchGroups: [Event.Url, Event.MediaId, Event.Title, Event.Cover]);
//
//  Agent domohformatAgent = EventFormatAgent(
//      findKey: [Event.Url],
//      Replaces: ["http://www.zzzfun.com/vod-detail-id-${Event.MediaId}.html"]);
//
//  agents[ParseType.homepage.index] = [
//    domohAgent,
//    demohRegexAgent,
//    domohformatAgent
//  ];
//
//  Agent domoinfoAgent = HttpAgent(
//      url: "http://www.zzzfun.com/vod-detail-id-${Event.MediaId}.html");
//  Agent domoinforegAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(r'name="description" content="(.*?)"'),
//      matchGroups: [Event.Intro]);
//
//  agents[ParseType.info.index] = [domoinfoAgent, domoinforegAgent];
//
//  Agent domoeposideformatAgent = EventFormatAgent(
//      findKey: [Event.Title, Event.EpisodeId],
//      Replaces: ["eposide event", "1"]);
//  agents[ParseType.Episode.index] = [domoinfoAgent, domoeposideformatAgent];
//
//  Agent domochapterformatAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(
//          r'<a class="" href="(.*?sid-(\d+)-nid-(\d+)\.html)" target="_blank"><span class="title">(.*?)<\/span>'),
//      matchGroups: [Event.Url, Event.EpisodeId, Event.ChapterId, Event.Title]);
//  agents[ParseType.Chapter.index] = [domoinfoAgent, domochapterformatAgent];
//
//  Agent zzzhttp1 = HttpAgent(
//      url:
//          "http://www.zzzfun.com/vod-play-id-${Event.MediaId}-sid-${Event.EpisodeId}-nid-${Event.ChapterId}.html");
//  Agent zzzregex1 = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(r'"link_pre":"(?:.*?)","url":"(.*?)"'),
//      matchGroups: [Event.Url]);
//  Agent zzzbase64de = Base64Agent(
//      text: Event.Url, resultSave: Event.Url, method: CodecAgent_Method.decode);
//  Agent zzzurlde = UrlCodecsAgent(
//      text: Event.Url, resultSave: Event.Url, method: CodecAgent_Method.decode);
//  Agent zzzhttp2 =
//      HttpAgent(url: "http://www.zzzfun.com/static/danmu/san.php?${Event.Url}");
//  Agent zzzregex2 = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(r'<source src="(.*?)"'),
//      matchGroups: [Event.Url]);
//
//  agents[ParseType.Source.index] = [
//    zzzhttp1,
//    zzzregex1,
//    zzzbase64de,
//    zzzurlde,
//    zzzhttp2,
//    zzzregex2
//  ]; //,zzzhttp2,zzzregex2];
//
//  return agents;
//}
//
//List<List<Agent>> _GenAcgyy() {
//  List<List<Agent>> agents = new List(ParseType.All.index);
//
//  Agent domohAgent = HttpAgent(url: "http://www.acgjc.com/yy/");
//  Agent demohRegexAgent = RegexpAgent(
//      matchBody: Event.Body,
//      regexp: RegExp(
//          r'<a\s+href="(.*?(\d+)\.html)"\s+title="(.*?)"[\s\S]+?src="(.*?jpg)"\s+alt=".*?"'),
//      matchGroups: [Event.Url, Event.MediaId, Event.Title, Event.Cover]);
//
////  Agent domohformatAgent = EventFormatAgent(
////      findKey: [Event.Url], Replaces: ["http://www.zzzfun.com/vod-detail-id-${Event.MediaId}.html"]);
//
//  agents[ParseType.homepage.index] = [
//    domohAgent,
//    demohRegexAgent,
////    domohformatAgent
//  ];
//
//  return agents;
//}

class AppShareData extends InheritedWidget {
  static const List<MaterialColor> AppThemeColors = [
    Colors.blue,
    Colors.pink,
    Colors.teal,
    Colors.red,
  ];

  ///////////////////////////////////////////////////

  //Saved Media
  static List<List<Media>> Favorite = new List(MediaType.All.index);
  static List<List<Media>> History = new List(MediaType.All.index);

  List<Parse> get AppParse {
    List<String> _parseStrings = prefs.getStringList(PREF_APP_AGENTLISTS);
    if (_parseStrings == null) {
//    if (true) {
      List<Parse> parses = LoadDefaultParses();
      print("set app parse default pref");
      prefs.setStringList(
          PREF_APP_AGENTLISTS, parses.map((p) => p.toString()).toList());
//      print("Load Default agents!");
      return parses;
    }

//    print("Load agents to Prefs!");
    return _parseStrings
        .map((parseString) => BaseParse.fromString(parseString))
        .toList();
  }

  set AppParse(List<Parse> parse) {
    prefs.setStringList(
        PREF_APP_AGENTLISTS, parse.map((p) => p.toString()).toList());
    print("Save agents to Prefs!");
  }

  addOrEditAppParse(Parse parse) {
    if (parse == null) return;

    List<Parse> parses = AppParse;

    if (parses.where((p) => p.info.uuid == parse.info.uuid).length != 0)
      parses.removeWhere((p) => p.info.uuid == parse.info.uuid);

    parses.add(parse);

    AppParse = parses;
  }

  removeParse(Parse parse) {
    if (parse == null) return;

    List<Parse> parses = AppParse;
    parses.removeWhere((p) => p.info.uuid == parse.info.uuid);
    AppParse = parses;
  }

  static AppShareData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppShareData);
  }

  //////////////////////////prefs///////////////////////
  static SharedPreferences prefs;
  static String PREF_APP_AGENTLISTS = "pref_app_agentlists";

  List<Parse> LoadDefaultParses() {
//    List<List<Agent>> expagents = _GenExpAgents();
    List<Parse> p= new List();

    // todo replace here
//    p.add(BaseParse(
//        agents: expagents, ParseUUID: "1c4c7f1e-35ff-410a-a7f1-ec1ce15c174d")
//      ..name = "50manhua"
//      ..url = "https://50mh.com"
//      ..type = MediaType.Image);
//    p.add(BaseParse(
//        agents: _GenAIXIA(), ParseUUID: "dfa1f15e-f70a-4bef-b765-3f2c064de94a")
//      ..name = "qidian"
//      ..url = "https://qidian.com"
//      ..type = MediaType.Article);
//
//    p.add(BaseParse(
//        agents: _Genzzzanime(),
//        ParseUUID: "c2601286-bd9d-4e3a-b604-13636e579e07")
//      ..name = "zzzfun"
//      ..url = "https://www.zzzfun.com"
//      ..type = MediaType.Video);
//
//    p.add(BaseParse(
//        agents: _GenAcgyy(), ParseUUID: "fe47aabd-b32b-41e2-b7d5-933dced8ad6b")
//      ..name = "acgjcyy"
//      ..url = "https://www.acgjc.com"
//      ..type = MediaType.Sound);

    return p;
  }

  AppShareData({
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppShareData oldWidget) =>
      oldWidget.AppParse != AppParse ||
//      oldWidget.History != History ||
//      oldWidget.Favorite != Favorite ||
      false; //debug use
}
