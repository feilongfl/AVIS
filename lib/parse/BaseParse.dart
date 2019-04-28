import 'dart:convert';

import '../media/Media.dart';
import 'common/Parse.dart';
import 'common/ParseAction.dart';
import 'common/ParseConst.dart';
import 'common/ParseInfo.dart';
import 'event/Event.dart';

class BaseParse implements Parse {
  ParseInfo info;
  ParseType type;
  List<ParseAction> actions;

  BaseParse({this.info, this.type, this.actions});

  Future<List<Media>> doWork(ParseActionType type, List<Event> events) async {}

  static const jsonKey_info = "info";
  static const jsonKey_type = "type";
  static const jsonKey_actions = "actions";

  static BaseParse fromJson(Map<String, dynamic> jsonObj) {
    return BaseParse(
      info: ParseInfo.fromString(jsonObj[jsonKey_info]),
      type: ParseType.values[jsonObj[jsonKey_type]],
      actions: jsonObj[jsonKey_actions]
          .cast<String>()
          .map((s) => ParseAction.fromString(s))
          .toList(),
    );
  }

  static BaseParse fromString(String str) {
    return fromJson(json.decode(str));
  }

  Map<String, dynamic> toJson() {
    return {
      jsonKey_info: info.toString(),
      jsonKey_type: type.index,
      jsonKey_actions: actions.map((a) => a.toString()).toList(),
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
