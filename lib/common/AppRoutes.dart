import 'package:url_launcher/url_launcher.dart';

class AppRoutes {
  static const String Home = "/";
  static const String Search = "/Search";
  static const String SearchResult = "/SearchResult";
  static const String SearchResultArg_type = "type";
  static const String SearchResultArg_keyword = "keyword";
  static const String Histroy = "/History";
  static const String Favorite = "/Favorite";
  static const String Download = "/Download";
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
  static const String SourceEdit = "/SourceSetting/SourceEdit";
  static const String AgentsEdit = "/SourceSetting/SourceEdit/AgentsEdit";
  static const String AgentsEditArgs_Agents = "agents";
  static const String AgentsEditArgs_ActionType = "actiontype";
  static const String AgentSelect =
      "/SourceSetting/SourceEdit/AgentsEdit/AgentSelect";
  static const String AgentConfig =
      "/SourceSetting/SourceEdit/AgentsEdit/AgentSelect/AgentConfig";
  static const String AgentDryRun = "/AgentDryRun";
  static const String PictureView = "/PictureView";
  static const String Settings_HomePageTabs = "/Setting/HomePageTabs";
  static const String Settings_HomePageTabs_edit = "/Setting/HomePageTabs/Edit";

  static LaunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
