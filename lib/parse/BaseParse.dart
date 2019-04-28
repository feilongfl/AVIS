import 'dart:convert';

import 'common/Parse.dart';
import 'common/ParseAction.dart';
import 'common/ParseConst.dart';
import 'common/ParseInfo.dart';
import 'event/Event.dart';

class BaseParse implements Parse {
  ParseInfo info;
  ParseType type;
  List<ParseAction> actions;

  int maxSearchPage = 1;
  int initSearchPage = 1;
  int maxHomePage = 1;
  int initHomePage = 1;

  BaseParse({
    this.info,
    this.type,
    this.actions,
    this.maxHomePage,
    this.maxSearchPage,
    this.initSearchPage,
    this.initHomePage,
  });

  Future<List<Event>> doWork(ParseActionType type, List<Event> eventsIn) async {
    List<Event> eventsOut = List();

    // select action
    for (Event e in eventsIn) {
      final ParseAction action = (e.Data[EventItems.Action] ??
              ParseActionType.All.index >= ParseActionType.All.index)
          ? null
          : actions[e.Data[EventItems.Action]];

      if (action == null) continue; // event action not found

      // do works
      switch (action.type) {
        case ParseActionType.Search:
          for (int i = initSearchPage; i <= maxSearchPage; i++)
            eventsOut.addAll(
                await action.doWork([e..Data[Event.PageNums] = i.toString()]));
          break;

        case ParseActionType.HomePage:
          for (int i = initHomePage; i <= maxHomePage; i++)
            eventsOut.addAll(
                await action.doWork([e..Data[Event.PageNums] = i.toString()]));
          break;

        default:
          eventsOut.addAll(await action.doWork([e]));
          break;
      }
    }

    return eventsOut;
  }

  static const jsonKey_info = "info";
  static const jsonKey_type = "type";
  static const jsonKey_actions = "actions";
  static const jsonKey_maxSearchPage = "maxSearchPage";
  static const jsonKey_maxHomePage = "maxHomePage";
  static const jsonKey_initSearchPage = "initSearchPage";
  static const jsonKey_initHomePage = "initHomePage";

  static BaseParse fromJson(Map<String, dynamic> jsonObj) {
    return BaseParse(
      info: ParseInfo.fromString(jsonObj[jsonKey_info]),
      type: ParseType.values[jsonObj[jsonKey_type]],
      actions: jsonObj[jsonKey_actions]
          .cast<String>()
          .map((s) => ParseAction.fromString(s))
          .toList(),
      maxSearchPage: jsonObj[jsonKey_maxSearchPage],
      maxHomePage: jsonObj[jsonKey_maxHomePage],
      initSearchPage: jsonObj[jsonKey_initSearchPage],
      initHomePage: jsonObj[jsonKey_initHomePage],
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
      jsonKey_maxSearchPage: maxSearchPage,
      jsonKey_maxHomePage: maxHomePage,
      jsonKey_initSearchPage: initSearchPage,
      jsonKey_initHomePage: initHomePage,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
