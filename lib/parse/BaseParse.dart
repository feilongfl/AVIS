import 'dart:convert';

import '../common/AppEnums.dart';
import 'common/Parse.dart';
import 'common/ParseAction.dart';
import 'common/ParseConst.dart';
import 'common/ParseInfo.dart';
import 'event/Event.dart';

class BaseParse implements Parse {
  ParseInfo info;
  ParseType type;
  List<ParseAction> actions;
  MediaType mediaType = MediaType.Article;

  int maxSearchPage = 1;
  int initSearchPage = 1;
  int maxHomePage = 1;
  int initHomePage = 1;

  BaseParse({
    this.info,
    this.type = ParseType.Source,
    this.actions,
    this.mediaType = MediaType.Article,
    this.maxHomePage = 1,
    this.maxSearchPage = 1,
    this.initSearchPage = 1,
    this.initHomePage = 1,
  }) {
    this.info = this.info ?? ParseInfo();
    this.actions = this.actions ?? List(ParseActionType.values.length);

    ParseActionType.values.forEach((t) {
      if (actions[t.index] == null) actions[t.index] = ParseAction(type: t);
    });
  }

  Future<List<Event>> doWork(
      ParseActionType actionType, List<Event> eventsIn) async {
    List<Event> eventsOut = List();

    // select action
    for (Event e in eventsIn) {
      try {
        final ParseAction action =
            actions.firstWhere((a) => a.type == actionType);

        if (action == null) continue; // event action not found

        // do works
        switch (action.type) {
          case ParseActionType.Search:
            for (int i = initSearchPage; i <= maxSearchPage; i++)
              eventsOut.addAll(await action
                  .doWork([e..Data[Event.PageNums] = i.toString()]));
            break;

          case ParseActionType.HomePage:
            for (int i = initHomePage; i <= maxHomePage; i++)
              eventsOut.addAll(await action
                  .doWork([e..Data[Event.PageNums] = i.toString()]));
            break;

          default:
            eventsOut.addAll(await action.doWork([e]));
            break;
        }
      } catch (e) {
        continue;
      }
    }

    return eventsOut;
  }

  static const jsonKey_info = "info";
  static const jsonKey_type = "type";
  static const jsonKey_actions = "actions";
  static const jsonKey_mediaType = "mediaType";
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
          .cast<ParseAction>()
          .toList(),
      mediaType: MediaType.values[jsonObj[jsonKey_mediaType]],
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
      jsonKey_mediaType: mediaType.index,
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
