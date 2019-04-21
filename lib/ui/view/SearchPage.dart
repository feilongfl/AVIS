import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../common/AppShareData.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends StateMVC {
  final TextEditingController textEditingController =
      new TextEditingController();

  MediaType type = MediaType.Image; //todo for test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: _searchPage(context),
    );
  }

  Widget _radioItem(BuildContext context, MediaType type) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            Radio(
                value: type,
                groupValue: this.type,
                onChanged: (v) {
                  setState(() {
                    this.type = v;
                  });
                }),
            Text(["Article", "Video", "Image", "Sound"][type.index]),
          ],
        ));
  }

  Widget _searchPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[]
//            ..add(Image.network(
//                "http://www.baidu.com/img/bd_logo1.png")) //todo change image
            ..add(Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: textEditingController,
                  )),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (textEditingController.toString() != "")
                        Navigator.of(context)
                            .pushNamed(AppRoutes.SearchResult, arguments: {
                          AppRoutes.SearchResultArg_type: type,
                          AppRoutes.SearchResultArg_keyword:
                              textEditingController.text
                        });
                    },
                  ),
                ],
              ),
            ))
            ..add(Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: MediaQuery.of(context).orientation == Orientation.landscape
                  ? Row(
                      children: <Widget>[
                        _radioItem(context, MediaType.Article),
                        _radioItem(context, MediaType.Video),
                        _radioItem(context, MediaType.Image),
                        _radioItem(context, MediaType.Sound),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _radioItem(context, MediaType.Article),
                            _radioItem(context, MediaType.Video),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            _radioItem(context, MediaType.Image),
                            _radioItem(context, MediaType.Sound),
                          ],
                        ),
                      ],
                    ),
            )),
        ),
      ),
    );
  }
}
