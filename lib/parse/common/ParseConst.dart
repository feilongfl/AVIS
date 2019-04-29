import 'package:flutter/material.dart';

enum ParseType {
  Source,
  scraper,
  subtitle,
  weather,
  //
  All,
}

enum ParseActionType {
  Search,
  Info,
  Eposide,
  Chapter,
  Source,
  SourceLazy,
  HomePage,
  //
//  All,
}

class ParseConst {
  static const List<ParseType> ParseTypes = [
    ParseType.Source,
    ParseType.scraper,
    ParseType.subtitle,
    ParseType.weather,
  ];

  static const List<IconData> ParseTypeIcons = [
    Icons.filter,
    Icons.scanner,
    Icons.subtitles,
    Icons.wb_sunny,
  ];

  static const List<String> ParseTypeStrings = [
    "Source",
    "scraper",
    "subtitles",
    "weather",
  ];

  static const List<ParseActionType> ParseActionTypes = [
    ParseActionType.Search,
    ParseActionType.Info,
    ParseActionType.Eposide,
    ParseActionType.Chapter,
    ParseActionType.Source,
    ParseActionType.SourceLazy,
    ParseActionType.HomePage,
  ];

  static const List<IconData> ParseActionTypeIcons = [
    Icons.search,
    Icons.info,
    Icons.sort,
    Icons.filter,
    Icons.image,
    Icons.landscape,
    Icons.home,
  ];

  static const List<String> ParseActionTypeStrings = [
    "Search",
    "Info",
    "Eposide",
    "Chapter",
    "Source",
    "SourceLazy",
    "HomePage",
  ];

  static bool ParseActionTypeVisibility(
      ParseType type, ParseActionType action) {
    switch (type) {
      case ParseType.Source:
        return true;
        break;

      case ParseType.weather:
        return false || action == ParseActionType.Info;
        break;

      case ParseType.subtitle:
      case ParseType.scraper:
        return false ||
            action == ParseActionType.Source ||
            action == ParseActionType.Search;
        break;

      default:
        return false;
        break;
    }
  }
}
