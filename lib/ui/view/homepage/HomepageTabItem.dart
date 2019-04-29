import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../UiConst.dart';

class HomepageTabItem {
  String name;
  List<String> parseUuids;

  ViewType viewType;

//  bool autoRefersh;
  bool autoLoadmore;

  String uuid;

  HomepageTabItem(
      {this.name = "Tabs",
      this.parseUuids,
      this.viewType = ViewType.GridView,
//      this.autoRefersh = false,
      this.autoLoadmore = true,
      this.uuid}) {
    this.parseUuids = this.parseUuids ?? List();
    uuid = uuid ?? Uuid().v4();
  }

  static const jsonKey_name = "name";
  static const jsonKey_parseUuid = "parseUuid";
  static const jsonKey_viewType = "viewType";
  static const jsonKey_autoRefersh = "autoRefersh";
  static const jsonKey_autoLoadmore = "autoLoadmore";
  static const jsonKey_uuid = "uuid";

  static HomepageTabItem fromJson(Map<String, dynamic> jsonObj) {
    return HomepageTabItem(
      name: jsonObj[jsonKey_name],
      parseUuids: jsonObj[jsonKey_parseUuid].cast<String>(),
      viewType: ViewType.values[jsonObj[jsonKey_viewType]],
//      autoRefersh: jsonObj[jsonKey_autoRefersh],
      autoLoadmore: jsonObj[jsonKey_autoLoadmore],
      uuid: jsonObj[jsonKey_uuid],
    );
  }

  static HomepageTabItem fromString(String str) {
    return fromJson(json.decode(str));
  }

  Map<String, dynamic> toJson() {
    return {
      jsonKey_name: name,
      jsonKey_parseUuid: parseUuids,
      jsonKey_viewType: viewType.index,
//      jsonKey_autoRefersh: autoRefersh,
      jsonKey_autoLoadmore: autoLoadmore,
      jsonKey_uuid: uuid,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
