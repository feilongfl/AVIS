import 'package:flutter/material.dart';

import '../Agent/Agent.dart';
import '../common/AppEnums.dart';
import '../media/Media.dart';

abstract class Parse {
  String ParseUUID;// source UUID
  String name;// Source Name
  String url;// Source URL
  MediaType type;
  String comment; //Source intro
  String updateUrl;// Source Parse Script Update URL
  String author; //Author
  String author_email; //Author e-mail
  String author_website; //Author website or blog

  List<List<Agent>> agents;

  Future<List<Media>> doWork(ParseType type, dynamic argv) async {
    return null;
  }

  static const List<ParseType> ParseTypeLists = [
    ParseType.Search,
    ParseType.info,
    ParseType.Episode,
    ParseType.Chapter,
    ParseType.Source,
    ParseType.SourceLazy,
    ParseType.homepage,
//    ParseType.login,
  ];

  static const List<IconData> ParseTypeIcons = [
    Icons.search,
    Icons.info,
    Icons.filter,
    Icons.image,
    Icons.file_download,
    Icons.keyboard_arrow_down,
    Icons.home,
    Icons.texture,
  ];

  static const List<String> ParseTypeStrings = [
    "Search",
    "info",
    "Episode",
    "Chapter",
    "Source",
    "SourceLazy",
    "homepage",
    "login",
  ];
}
