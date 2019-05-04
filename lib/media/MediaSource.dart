import 'dart:convert';

import 'MeidaConst.dart';

class MediaSource {
  List<String> urls = List();
  String name;

//  List<String> referer = List();
//  List<String> cookies = List();
  List<Map<String, String>> header = List();

  MediaSource({this.name, this.urls, this.header});

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Urls: urls,
      MediaConst.Title: name,
      MediaConst.Header: header,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
