import 'dart:convert';

import '../../UiConst.dart';

class HomepageTabItem {
  String name;
  List<String> parseUuid;

  ViewType viewType;

  bool autoRefersh;
  bool autoLoadmore;

  HomepageTabItem({
    this.name = "Tabs",
    this.parseUuid = const [],
    this.viewType = ViewType.GridView,
    this.autoRefersh = false,
    this.autoLoadmore = true,
  });

  static const jsonKey_name = "name";
  static const jsonKey_parseUuid = "parseUuid";
  static const jsonKey_viewType = "viewType";
  static const jsonKey_autoRefersh = "autoRefersh";
  static const jsonKey_autoLoadmore = "autoLoadmore";

  static HomepageTabItem fromJson(Map<String, dynamic> jsonObj) {
    return HomepageTabItem(
      name: jsonObj[jsonKey_name],
      parseUuid: jsonObj[jsonKey_parseUuid],
      viewType: jsonObj[jsonKey_viewType],
      autoRefersh: jsonObj[jsonKey_autoRefersh],
      autoLoadmore: jsonObj[jsonKey_autoLoadmore],
    );
  }

  static HomepageTabItem fromString(String str) {
    return fromJson(json.decode(str));
  }

  Map<String, dynamic> toJson() {
    return {
      jsonKey_name: name,
      jsonKey_parseUuid: parseUuid,
      jsonKey_viewType: viewType,
      jsonKey_autoRefersh: autoRefersh,
      jsonKey_autoLoadmore: autoLoadmore,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}