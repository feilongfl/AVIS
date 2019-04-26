import 'package:flutter/material.dart';

import '../Agent/EventFormatAgent.dart';
import '../Agent/HttpAgent.dart';
import '../Agent/RegexpAgent.dart';
import '../Agent/common/Agent.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import '../parse/BaseParse.dart';
import '../parse/common/Parse.dart';
import 'AppEnums.dart';

List<List<Agent>> _GenExpAgents() {
  List<List<Agent>> agents = new List(ParseType.All.index);

  Agent domoAgent = HttpAgent(
    url: "https://www.50mh.com/search/?keywords=" + Event.SearchKeyword,
  );
  Agent demoRegexAgent = RegexpAgent(
      RegExp(
          r'<a class="image-link" href="(https.*?manhua\/(.*?)\/?)" title="(.*?)"><img src="(.*?)" width="\d+" height="\d+" alt="" default="(?:.*?)">'),
      [Event.Url, Event.MediaId, Event.Title, Event.Cover]);

  Agent domohAgent = HttpAgent(url: "https://www.50mh.com/list/riben/");
  Agent demohRegexAgent = RegexpAgent(
      RegExp(
          '<a class="comic_img" href="(http.*?manhua\\/(.*?)\\/)"><img src="(.*?)" alt="(.*?)"'),
      [Event.Url, Event.MediaId, Event.Cover, Event.Title]);

  Agent domoinfoAgent = HttpAgent(
    url: "https://www.50mh.com/manhua/${Event.MediaId}/",
  );
  Agent demoinfoRegexAgent = RegexpAgent(
      RegExp(r'<meta name="description" content="(.*?)">'), [Event.Intro]);

  Agent demoepiinfoRegexAgent =
      RegexpAgent(RegExp(r'<em class="c_3">(.*?)列表<\/em>'), [Event.Title]);

  Agent democpiinfoRegexAgent = RegexpAgent(
      RegExp(r'<li>\s+<a href="(.*\/(\d+).*?)" title="(.*?)"'),
      [Event.Url, Event.ChapterId, Event.Title]);

  agents[ParseType.homepage.index] = [
    domohAgent,
    demohRegexAgent,
  ];

  agents[ParseType.Search.index] = [domoAgent, demoRegexAgent];
  agents[ParseType.info.index] = [domoinfoAgent, demoinfoRegexAgent];
  agents[ParseType.Episode.index] = [domoinfoAgent, demoepiinfoRegexAgent];
  agents[ParseType.Chapter.index] = [domoinfoAgent, democpiinfoRegexAgent];

  return agents;
}

List<List<Agent>> _GenAIXIA() {
  List<List<Agent>> agents = new List(ParseType.All.index);

  Agent domohAgent = HttpAgent(
      url:
          "https://m.qidian.com/category/detail?catId=21&subCatId=8&gender=male");
  Agent demohRegexAgent = RegexpAgent(
      RegExp(
          r'<a href="(.*\/(\d+))" class="book-layout">\s+<img src="(?:.*?)" data-src="(.*?)" class="book-cover" alt="(.*?)">\s+<div class="book-cell">\s+<div class="book-title-x">\s+<div class="book-title-r">\s+<\/div>\s+<h4 class="book-title">(?:.*?)<\/h4>\s+<\/div>\s+<p class="book-desc"> (.*?)<\/p>'),
      [Event.Url, Event.MediaId, Event.Cover, Event.Title, Event.Intro]);

  Agent domohformatAgent = EventFormatAgent(
      findKey: [Event.Cover], Replaces: ["http:${Event.Cover}"]);

  agents[ParseType.homepage.index] = [
    domohAgent,
    demohRegexAgent,
    domohformatAgent
  ];

  return agents;
}

List<List<Agent>> _Genzzzanime() {
  List<List<Agent>> agents = new List(ParseType.All.index);

  Agent domohAgent = HttpAgent(url: "http://www.zzzfun.com/map-index.html");
  Agent demohRegexAgent = RegexpAgent(
      RegExp(
          r'<a href="(\/vod-detail-id-(\d+)\.html)" style="\s+color: #fffee4;\s+">(.*?)<\/a><em>\/<\/em><\/h5>\s+<div class="tipInfo">\s+<div class="play-img"><img src="(.*?)" alt="(?:.*?)" \/>'),
      [Event.Url, Event.MediaId, Event.Title, Event.Cover]);

  Agent domohformatAgent = EventFormatAgent(
      findKey: [Event.Url],
      Replaces: ["http://www.zzzfun.com/vod-detail-id-${Event.MediaId}.html"]);

  agents[ParseType.homepage.index] = [
    domohAgent,
    demohRegexAgent,
    domohformatAgent
  ];

  Agent domoinfoAgent = HttpAgent(
      url: "http://www.zzzfun.com/vod-detail-id-${Event.MediaId}.html");
  Agent domoinforegAgent =
      RegexpAgent(RegExp(r'name="description" content="(.*?)"'), [Event.Intro]);

  agents[ParseType.info.index] = [domoinfoAgent, domoinforegAgent];

  Agent domoeposideformatAgent = EventFormatAgent(
      findKey: [Event.Title, Event.EpisodeId],
      Replaces: ["eposide event", "1"]);
  agents[ParseType.Episode.index] = [domoinfoAgent, domoeposideformatAgent];

  Agent domochapterformatAgent = RegexpAgent(
      RegExp(
          r'<a class="" href="(.*?sid-(\d+)-nid-(\d+)\.html)" target="_blank"><span class="title">(.*?)<\/span>'),
      [Event.Url, Event.EpisodeId, Event.ChapterId, Event.Title]);
  agents[ParseType.Chapter.index] = [domoinfoAgent, domochapterformatAgent];

  return agents;
}

List<List<Agent>> _GenAcgyy() {
  List<List<Agent>> agents = new List(ParseType.All.index);

  Agent domohAgent = HttpAgent(url: "http://www.acgjc.com/yy/");
  Agent demohRegexAgent = RegexpAgent(
      RegExp(
          r'<a\s+href="(.*?(\d+)\.html)"\s+title="(.*?)"[\s\S]+?src="(.*?jpg)"\s+alt=".*?"'),
      [Event.Url, Event.MediaId, Event.Title, Event.Cover]);

//  Agent domohformatAgent = EventFormatAgent(
//      findKey: [Event.Url], Replaces: ["http://www.zzzfun.com/vod-detail-id-${Event.MediaId}.html"]);

  agents[ParseType.homepage.index] = [
    domohAgent,
    demohRegexAgent,
//    domohformatAgent
  ];

  return agents;
}

class AppShareData extends InheritedWidget {
  static const String AppName = "AVIS";
  static const String defaultKeywords = "UnknowKeywords";

  static const String FEILONG = "FeiLong";
  static const String FEILONGBLOG = "https://feilong.home.blog";
  static const String GITHUB = "https://github.com/feilongfl/AVIS";
  static const String GITHUBRELEASE = "$GITHUB/releases";

  static const String finishTip_isFin = "Finish";
  static const String finishTip_notFin = "not Finish";

  ///////////////////////////////////////////////////
  // theme data
  static List<MaterialColor> AppThemeColors = [
    Colors.blue,
    Colors.pink,
    Colors.teal,
    Colors.red,
  ];

  ///////////////////////////////////////////////////

  //Saved Media
//  static List<List<Media>> Rss =
//      new List(MediaType.All.index); //rss source for homepage
  static List<List<Media>> Favorite = new List(MediaType.All.index);
  static List<List<Media>> History = new List(MediaType.All.index);

  //parse config
  List<List<Parse>> AppParse = new List(MediaType.All.index);

  static AppShareData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppShareData);
  }

  AppShareData({
    @required Widget child,
  }) : super(child: child) {
    //read from storage here
    for (int i = 0; i < MediaType.All.index; i++) {
      this.AppParse[i] = new List();
    }

    //exp agents
    List<List<Agent>> expagents = _GenExpAgents();

    // for debug use
    this.AppParse[MediaType.Image.index].add(BaseParse(
        agents: expagents, ParseUUID: "1c4c7f1e-35ff-410a-a7f1-ec1ce15c174d")
      ..name = "50manhua"
      ..url = "https://50mh.com"
      ..type = MediaType.Image);
    this.AppParse[MediaType.Article.index].add(BaseParse(
        agents: _GenAIXIA(), ParseUUID: "dfa1f15e-f70a-4bef-b765-3f2c064de94a")
      ..name = "qidian"
      ..url = "https://qidian.com"
      ..type = MediaType.Article);

    this.AppParse[MediaType.Video.index].add(BaseParse(
        agents: _Genzzzanime(),
        ParseUUID: "c2601286-bd9d-4e3a-b604-13636e579e07")
      ..name = "zzzfun"
      ..url = "https://www.zzzfun.com"
      ..type = MediaType.Video);

    this.AppParse[MediaType.Sound.index].add(BaseParse(
        agents: _GenAcgyy(), ParseUUID: "fe47aabd-b32b-41e2-b7d5-933dced8ad6b")
      ..name = "acgjcyy"
      ..url = "https://www.acgjc.com"
      ..type = MediaType.Sound);

    // copy test
//    var a = this.AppParse[MediaType.Image.index][0].toString();
//    this
//        .AppParse[MediaType.Image.index]
//        .add(ParseCreator.fromString(a)..name = "copy");
  }

  @override
  bool updateShouldNotify(AppShareData oldWidget) =>
      oldWidget.AppParse != AppParse ||
//      oldWidget.History != History ||
//      oldWidget.Favorite != Favorite ||
      false; //debug use
}
