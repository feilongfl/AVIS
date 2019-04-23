import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../parse/BaseParse.dart';
import '../../parse/Parse.dart';

class SourceEditPage extends StatefulWidget {
  Parse parse;

  SourceEditPage(this.parse, {Key key}) : super(key: key);

  @override
  SourceEditState createState() => SourceEditState(this.parse);
}

class SettingForm {
  IconData icon;
  String label;
  String hint;
  bool editable;
  List<String> choiceStrings;
  List<dynamic> choiceValues;
  dynamic bindValue;

  ValueChanged<dynamic> onChanged;

  SettingFormType type;

  SettingForm(this.label,
      {this.icon = Icons.label,
      this.hint = "",
      this.editable = true,
      this.type = SettingFormType.Input,
      this.choiceStrings,
      this.choiceValues,
      this.bindValue,
      this.onChanged});
}

class SourceEditState extends StateMVC {
  SourceEditController controller;

  SourceEditState(Parse parse) : super() {
    controller = SourceEditController(parse);
  }

  Widget _formInput({IconData icon, String label, String hint, bool editable}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: TextFormField(
        enabled: editable ?? true,
        maxLines: 1,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            icon: Icon(icon ?? Icons.label),
            labelText: label ?? "label",
            hintText: hint ?? "hint"),
      ),
    );
  }

  Widget _formSelect(String name, List<String> strings, List<dynamic> values,
      dynamic defaultValue, ValueChanged<dynamic> onChanged) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: ListTile(
          title: Text(name),
          trailing: DropdownButton(
              value: defaultValue,
              items: values
                  .map((v) => DropdownMenuItem<MediaType>(
                        value: v,
                        child: Text(strings[v.index]),
                      ))
                  .toList(),
              onChanged: (v) => controller.update()),
        ));
  }

  Widget _formDevide(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, bottom: 3, top: 3),
      child: Text(
        name,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Source Edit"),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        child: Icon(Icons.save),
//      ),
      body: ListView(
          children: []
            ..add(Container(
              color: Theme.of(context).primaryColorLight,
              padding:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? EdgeInsets.only(top: 30, bottom: 20)
                      : EdgeInsets.only(top: 160, bottom: 130),
              child: Column(
                children: <Widget>[
                  Text(
                    "Sources Edit",
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
            ))
            ..add(Padding(padding: EdgeInsets.only(top: 10)))
            ..add(_formDevide("Base Info"))
            ..add(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: TextFormField(
                initialValue: controller.parse.name,
                onSaved: (v) => setState(() => controller.parse.name = v),
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.label),
                    labelText: "Source Name",
                    hintText: "Input source name."),
              ),
            ))
            ..add(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.label),
                    labelText: "Source Url",
                    hintText: "Input source web url."),
              ),
            ))
            ..add(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.label),
                    labelText: "Source UUID",
                    hintText: "UUID for source."),
              ),
            ))
            ..add(Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: ListTile(
                  title: Text("Media Type"),
                  trailing: DropdownButton(
                      value: controller.parse.type,
                      items: SourceEditController.MediaTypeLists.map((v) =>
                          DropdownMenuItem<MediaType>(
                            value: v,
                            child: Text(
                                SourceEditController.MediaTypeStrings[v.index]),
                          )).toList(),
                      onChanged: (v) =>
                          setState(() => controller.parse.type = v)),
                )))
            ..add(_formDevide("Agents"))
//            ..addAll(controller.settingForms.map((s) {
//              switch (s.type) {
//                case SettingFormType.Devide:
//                  return _formDevide(s.label);
//
//                case SettingFormType.Input:
//                  return _formInput(
//                      icon: s.icon,
//                      label: s.label,
//                      hint: s.hint,
//                      editable: s.editable);
//                  break;
//
//                case SettingFormType.Choice:
//                  return _formSelect(s.label, s.choiceStrings, s.choiceValues,
//                      s.bindValue, s.onChanged);
//                  break;
//
//                default:
//                  return Text("error");
//                  break;
//              }
//            }))
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

//  List<SettingForm> settingForms;

//  void update() {
//    settingForms = [
//      SettingForm("Base Info", type: SettingFormType.Devide),
//      SettingForm("Source Name", hint: "Input source name.", icon: Icons.label),
//      SettingForm("Source Url",
//          hint: "Input source web url.", icon: Icons.link),
//      SettingForm("Source UUID",
//          hint: "Source UUID.", icon: Icons.code, editable: true),
//      SettingForm("Agent", type: SettingFormType.Devide),
//      SettingForm("Media Type",
//          type: SettingFormType.Choice,
//          choiceStrings: _mediaTypeStrings,
//          choiceValues: _mediaTypeLists,
//          bindValue: this.parse.type, onChanged: (v) {
//        setState(() => this.parse.type = v);
//      }),
//    ];
//  }

  SourceEditController(this.parse) {
    this.parse = this.parse ?? BaseParse(List(ParseType.All.index));
//    update();
  }
}
