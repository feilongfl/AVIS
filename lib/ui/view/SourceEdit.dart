import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../parse/Parse.dart';
import '../model/SourceEditPageModel.dart';

class SourceEditPage extends StatefulWidget {
  SourceEditPage({Key key}) : super(key: key);

  @override
  SourceEditState createState() => SourceEditState();
}

class SourceEditState extends StateMVC {
  SourceEditController controller;

  SourceEditState() : super() {
    controller = SourceEditController();
  }

  List<Widget> _agentSettingButton(BuildContext context) {
    return SourceEditController.ParseTypeLists.map((p) => ListTile(
          leading: Icon(SourceEditController.ParseTypeIcons[p.index]),
          title:
              Text(SourceEditController.ParseTypeStrings[p.index] + " Agents"),
          trailing: Icon(Icons.keyboard_arrow_right),
        )).toList();
  }

  Widget _divideText(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Source Edit"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.help), onPressed: () {}),
          IconButton(icon: Icon(Icons.save), onPressed: () {}),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          setState(() => SourceEditPageModel.of(context).name = "feilong");
//        },
//        child: Icon(Icons.save),
//      ),
      body: Form(
        child: ListView(
            children: <Widget>[]
              ..add(_divideText("Base Info"))
              ..add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(
                  initialValue: SourceEditPageModel.of(context).name,
                  decoration: InputDecoration(
                      labelText: "Source Name", hintText: "Input source name."),
                  onSaved: (v) => SourceEditPageModel.of(context).name = v,
                ),
              ))
              ..add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(
                  initialValue: SourceEditPageModel.of(context).url,
                  decoration: InputDecoration(
                      labelText: "Source Url",
                      hintText: "Input source web url."),
                  onSaved: (v) => SourceEditPageModel.of(context).url = v,
                ),
              ))
              ..add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(
                  initialValue: SourceEditPageModel.of(context).ParseUUID,
                  decoration: InputDecoration(
                      labelText: "Source UUID", hintText: "Source UUID."),
                  onSaved: (v) => SourceEditPageModel.of(context).ParseUUID = v,
                ),
              ))
              ..add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  title: Text("Media Type"),
                  trailing: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButtonFormField(
                      items: SourceEditController.MediaTypeLists.map(
                          (t) => DropdownMenuItem(
                              value: t,
                              child: Text(
                                SourceEditController.MediaTypeStrings[t.index],
                              ))).toList(),
                      value: SourceEditPageModel.of(context).type,
                      onChanged: (v) => setState(
                          () => SourceEditPageModel.of(context).type = v),
                    ),
                  ),
                ),
              ))
              ..add(_divideText("Agent Settings"))
              ..addAll(_agentSettingButton(context))
            //add,
            ),
      ),
    );
  }
}

enum SettingFormType {
  Input,
  Choice,
  Devide,
  //all
  All,
}

class SourceEditController extends ControllerMVC {
  Parse parse;

  static const List<MediaType> MediaTypeLists = [
    MediaType.Article,
    MediaType.Video,
    MediaType.Image,
    MediaType.Sound,
  ];

  static const List<String> MediaTypeStrings = [
    "Article",
    "Video",
    "Image",
    "Sound",
  ];

  static const List<ParseType> ParseTypeLists = [
    ParseType.Search,
    ParseType.info,
    ParseType.Episode,
    ParseType.Chapter,
    ParseType.Source,
    ParseType.SourceLazy,
    ParseType.homepage,
    ParseType.login,
  ];

  static const List<IconData> ParseTypeIcons = [
    Icons.search,
    Icons.texture,
    Icons.texture,
    Icons.texture,
    Icons.texture,
    Icons.texture,
    Icons.home,
    Icons.texture,
  ];

  static const List<String> ParseTypeStrings = [
    "Search",
    "info",
    "Episode",
    "Chapter",
    "Source",
    "SourceLazy",
    "homepage",
    "login",
  ];

  SourceEditController() {
//    this.parse = this.parse ?? BaseParse(List(ParseType.All.index));
  }
}
