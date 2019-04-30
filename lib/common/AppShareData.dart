import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../media/Media.dart';
import '../parse/BaseParse.dart';
import '../parse/common/Parse.dart';
import '../ui/view/homepage/HomepageTabItem.dart';
import 'AppEnums.dart';

class AppShareData extends InheritedWidget {
  static const List<MaterialColor> AppThemeColors = [
    Colors.blue,
    Colors.pink,
    Colors.teal,
    Colors.red,
  ];

  ///////////////////////////////////////////////////

  //Saved Media
  static List<List<Media>> favorite = new List(MediaType.All.index);
  static List<List<Media>> history = new List(MediaType.All.index);

  List<Parse> get appParse {
    List<String> _parseStrings = prefs.getStringList(PREF_APP_AGENTLISTS);
    if (_parseStrings == null) {
//    if (true) {
      List<Parse> parses = loadDefaultParses();
      print("set app parse default pref");
      prefs.setStringList(
          PREF_APP_AGENTLISTS, parses.map((p) => p.toString()).toList());
//      print("Load Default agents!");
      return parses;
    }

//    print("Load agents to Prefs!");
    return _parseStrings
        .map((parseString) => BaseParse.fromString(parseString))
        .toList();
  }

  set appParse(List<Parse> parse) {
    prefs.setStringList(
        PREF_APP_AGENTLISTS, parse.map((p) => p.toString()).toList());
    print("Save agents to Prefs!");
  }

  addOrEditAppParse(Parse parse) {
    if (parse == null) return;

    List<Parse> parses = appParse;

    if (parses.where((p) => p.info.uuid == parse.info.uuid).length != 0)
      parses.removeWhere((p) => p.info.uuid == parse.info.uuid);

    parses.add(parse);

    appParse = parses;
  }

  removeParse(Parse parse) {
    if (parse == null) return;

    List<Parse> parses = appParse;
    parses.removeWhere((p) => p.info.uuid == parse.info.uuid);
    appParse = parses;
  }

  static AppShareData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppShareData);
  }

  //////////////////////////prefs///////////////////////
  static SharedPreferences prefs;
  static const String PREF_APP_AGENTLISTS = "pref_app_agentlists";
  static const String PREF_APP_HomePageTabs = "pref_app_homepage_tabs";

  //////////////////////////HomepageTabItem///////////////////////
  List<HomepageTabItem> get homepageTabItems {
    List<String> _homepageTabsStrings =
        prefs.getStringList(PREF_APP_HomePageTabs);

    if (_homepageTabsStrings == null) return List();

    return _homepageTabsStrings
        .map((_hs) => HomepageTabItem.fromString(_hs))
        .toList();
  }

  set homepageTabItems(List<HomepageTabItem> hs) {
    prefs.setStringList(
        PREF_APP_HomePageTabs, hs.map((h) => h.toString()).toList());
    print("Save homepagetabs to Prefs!");
  }

  //add or edit
  homepageTabItemAdd(HomepageTabItem hs) {
    if (hs == null) return;
    bool match = false;
    List<HomepageTabItem> htemp = homepageTabItems;

    for (int i = 0; i < htemp.length; i++) {
      if (hs.uuid == htemp[i].uuid) {
        match = true;
        htemp[i] = hs;
      }
    }

    if (!match) htemp.add(hs);

    homepageTabItems = htemp;
  }

  homepageTabItemRemove(HomepageTabItem hs) {
    if (hs == null) return;

    homepageTabItems = homepageTabItems..removeWhere((h) => h.uuid == hs.uuid);
  }

  //////////////////////////HomepageTabItem///////////////////////

  List<Parse> loadDefaultParses() {
//    List<List<Agent>> expagents = _GenExpAgents();
    List<Parse> p = new List();

    // todo add demo here

    return p;
  }

  AppShareData({
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppShareData oldWidget) =>
      oldWidget.appParse != appParse ||
      oldWidget.homepageTabItems != homepageTabItems ||
//      oldWidget.History != History ||
//      oldWidget.Favorite != Favorite ||
      false; //debug use
}
