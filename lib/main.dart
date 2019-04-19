import 'package:avis/MyApp.dart';
import 'package:flutter/material.dart';

import 'common/AppEnums.dart';
import 'common/AppShareData.dart';
import 'parse/DemoParse.dart';

void initAppParse() {
  for (int i = 0 ; i < MediaType.All.index;i++){
    AppShareData.AppParse[MediaType.Image.index] = new List();
  }

  // for debug use
  AppShareData.AppParse[MediaType.Image.index].add(DemoParse());
}

void init() {
  initAppParse();
}

void main() {
  init();
  runApp(MyApp());
}
