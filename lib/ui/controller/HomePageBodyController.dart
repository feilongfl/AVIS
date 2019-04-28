import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../media/Media.dart';
import '../../parse/ParseRunner/ParseRunner.dart';

class HomePageBodyController extends ControllerMVC {
  HomePages page_type;

  HomePageBodyController(this.page_type);

  Future<List<Media>> getMedias(BuildContext context) async {
    return ParseRunner.Homepage(context, page_type);
  }
}
