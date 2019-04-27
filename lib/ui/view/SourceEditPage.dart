import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../common/AppRoutes.dart';
import '../../common/AppShareData.dart';
import '../../parse/common/Parse.dart';
import '../model/SourceEditPageModel.dart';
import '../widget/SettingDivideText.dart';

class SourceEditPage extends StatefulWidget {
  SourceEditPage({Key key}) : super(key: key);

  @override
  SourceEditState createState() => SourceEditState();
}

class SourceEditState extends StateMVC {
  SourceEditController controller;
  var _formKey = GlobalKey<FormState>();

  SourceEditState() : super() {
    controller = SourceEditController();
  }

  List<Widget> _agentSettingButton(BuildContext context) {
    return Parse.ParseTypeLists.map((p) => ListTile(
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.AgentsEdit, arguments: p),
          leading: Icon(Parse.ParseTypeIcons[p.index]),
          title: Text(Parse.ParseTypeStrings[p.index] + " Agents"),
          trailing: Icon(Icons.keyboard_arrow_right),
        )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Source Edit"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.help), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                _formKey.currentState.save();

                Parse parse = SourceEditPageModel.of(context);
                AppShareData.of(context).addOrEditAppParse(parse);

                Navigator.of(context).pop(parse);
              }),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          setState(() => SourceEditPageModel.of(context).name = "feilong");
//        },
//        child: Icon(Icons.save),
//      ),
      body: Form(
        key: _formKey,
        child: ListView(
            children: <Widget>[]
              ..add(SettingDevideText("Base Info"))
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Source Type"),
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
              ))
              ..add(SettingDevideText("Agent Settings"))
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

  SourceEditController() {
//    this.parse = this.parse ?? BaseParse(List(ParseType.All.index));
  }
}
