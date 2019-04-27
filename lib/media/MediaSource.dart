import 'dart:convert';

import 'MeidaConst.dart';

class MediaSource {
  List<String> urls;

  Map<String, dynamic> toJson() {
    return {
      MediaConst.Urls: urls,
    };
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
