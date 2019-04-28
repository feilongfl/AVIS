import 'package:flutter/material.dart';

enum ParseType {
  //
  Source,
  //
  scraper,
  subtitle,
  //
  weather,
  //
  all,
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
}
