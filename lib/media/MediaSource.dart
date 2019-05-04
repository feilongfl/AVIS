import 'dart:convert';

import 'MeidaConst.dart';

class MediaSource {
  List<String> urls = List();
  String name;

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Urls: urls,
      MediaConst.Title: name,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
