import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends StateMVC {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search"),),
      body: _searchPage(context),
    );
  }

  Widget _searchPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[]..add(
            Image.network(
                "http//www.baidu.com/img/bd_logo1.png")) //todo change image
          ..add(
              Flexible(child: Text("SearchBar"))),
      ),
    );
  }
}