import 'package:url_launcher/url_launcher.dart';

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
