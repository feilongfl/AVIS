import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Agent/HttpAgent.dart';
import '../Agent/RegexpAgent.dart';
import '../Agent/common/Agent.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import '../parse/BaseParse.dart';
import '../parse/Parse.dart';
import 'AppEnums.dart';

List<List<Agent>> GenExpAgents() {
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

  agents[ParseType.homepage.index] = [domohAgent, demohRegexAgent];
  agents[ParseType.Search.index] = [domoAgent, demoRegexAgent];
  agents[ParseType.info.index] = [domoinfoAgent, demoinfoRegexAgent];
  agents[ParseType.Episode.index] = [domoinfoAgent, demoepiinfoRegexAgent];
  agents[ParseType.Chapter.index] = [domoinfoAgent, democpiinfoRegexAgent];

  print(domoAgent.toString());
  print(demoRegexAgent.toString());

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

  //Saved Media
  static List<List<Media>> Rss =
      new List(MediaType.All.index); //rss source for homepage
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
    List<List<Agent>> expagents = GenExpAgents();

    // for debug use
    this.AppParse[MediaType.Image.index].add(BaseParse(
        agents: expagents, ParseUUID: "1c4c7f1e-35ff-410a-a7f1-ec1ce15c174d")
      ..name = "50manhua"
      ..url = "https://50mh.com"
      ..type = MediaType.Image);
  }

  @override
  bool updateShouldNotify(AppShareData oldWidget) =>
      oldWidget.AppParse != AppParse ||
//      oldWidget.History != History ||
//      oldWidget.Favorite != Favorite ||
      false; //debug use
}

class AppRoutes {
  static const String Home = "/";
  static const String Search = "/Search";
  static const String SearchResult = "/SearchResult";
  static const String SearchResultArg_type = "type";
  static const String SearchResultArg_keyword = "keyword";
  static const String Histroy = "/History";
  static const String Favorite = "/Favorite";
  static const String Backup = "/Backup";
  static const String SourceSetting = "/SourceSetting";
  static const String Setting = "/Setting";
  static const String Donate = "/Donate";
  static const String About = "/About";
  static const String MediaInfo = "/MediaInfo";
  static const String MediaView = "/MediaView";
  static const String MediaViewArg_Media = "media";
  static const String MediaViewArg_EposideId = "eposide";
  static const String MediaViewArg_ChapterId = "chapter";
  static const String SourceEdit = "/SourceEdit";
  static const String AgentsEdit = "/AgentsEdit";
  static const String AgentsEditArgs_Parse = "parse";
  static const String AgentsEditArgs_ParseType = "parsetype";
  static const String AgentSelect = "/AgentSelect";
  static const String AgentConfig = "/AgentConfig";
  static const String AgentDryRun = "/AgentDryRun";

  static LaunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HttpUserAgent {
  static const String Linux_Chrome =
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36";
}
