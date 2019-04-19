import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../common/AppShareData.dart';

class SearchResultPage extends StatefulWidget {
  MediaType type;
  String keyword;

  SearchResultPage(this.type, this.keyword, {Key key}) : super(key: key);

  @override
  _SearchResultPageState createState() =>
      _SearchResultPageState(this.type, this.keyword);
}

class _SearchResultPageState extends StateMVC {
  SearchResultPageController searchResultPageController;

  _SearchResultPageState(MediaType type, String keyword) {
    searchResultPageController = new SearchResultPageController(type, keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Text(
          searchResultPageController.keyword ?? AppShareData.defaultKeywords),
    );
  }
}

class SearchResultPageController extends ControllerMVC {
  MediaType type;
  String keyword;

  SearchResultPageController(MediaType type, String keyword) {
    this.type = type;
    this.keyword = keyword;
  }
}
