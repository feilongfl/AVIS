import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../common/AppEnums.dart';
import '../../../common/AppRoutes.dart';
import '../../../common/AppShareData.dart';
import '../../../generated/i18n.dart';
import '../../../parse/common/Parse.dart';
import '../../../parse/common/ParseConst.dart';
import '../../widget/SettingDivideText.dart';

class SourceEditPage extends StatefulWidget {
  Parse parse;

  SourceEditPage(this.parse, {Key key}) : super(key: key);

  @override
  SourceEditState createState() => SourceEditState(parse);
}

class SourceEditState extends StateMVC {
  SourceEditController controller;
  Parse parse;
  var _formKey = GlobalKey<FormState>();

  SourceEditState(this.parse) : super() {
    controller = SourceEditController();
  }

  List<Widget> _agentSettingButton(BuildContext context) {
    return ParseConst.ParseActionTypes.map((p) => Visibility(
          visible: ParseConst.ParseActionTypeVisibility(parse.type, p),
          child: ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed(AppRoutes.AgentsEdit, arguments: p),
            leading: Icon(ParseConst.ParseActionTypeIcons[p.index]),
            title: Text(ParseConst.ParseActionTypeStrings[p.index] +
                " " +
                S.of(context).Agents),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Source_Edit),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.help), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                _formKey.currentState.save();

//                Parse parse = parse;
                AppShareData.of(context).addOrEditAppParse(parse);

                Navigator.of(context).pop(parse);
              }),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          setState(() => parse.name = "feilong");
//        },
//        child: Icon(Icons.save),
//      ),
      body: Form(
        key: _formKey,
        child: ListView(
            children: <Widget>[]
              ..add(SettingDevideText(S.of(context).Base_Info))
              ..add(ListTile(
                title: TextFormField(
                  initialValue: parse.info.name,
                  decoration: InputDecoration(
                      labelText: S.of(context).Source_Name,
                      hintText: S.of(context).Source_Name_hint),
                  onSaved: (v) => parse.info.name = v,
                ),
              ))
              ..add(ListTile(
                title: TextFormField(
                  initialValue: parse.info.url,
                  decoration: InputDecoration(
                      labelText: S.of(context).Source_Url,
                      hintText: S.of(context).Source_Url_hint),
                  onSaved: (v) => parse.info.url = v,
                ),
              ))
              ..add(ListTile(
                title: TextFormField(
                  initialValue: parse.info.uuid,
                  decoration: InputDecoration(
                      labelText: S.of(context).Source_UUID,
                      hintText: S.of(context).Source_UUID_hint),
                  onSaved: (v) => parse.info.uuid = v,
                ),
              ))
              ..add(ListTile(
                title: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "Parse Type"),
                  items: ParseConst.ParseTypes.map((pt) => DropdownMenuItem(
                          value: pt,
                          child: Text(ParseConst.ParseTypeStrings[pt.index])))
                      .toList(),
                  value: parse.type,
                  onChanged: (v) => setState(() => parse.type = v),
                ),
              ))
              ..add(Visibility(
                visible: parse.type == ParseType.Source,
                child: ListTile(
                  title: DropdownButtonFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).Source_Type),
                    items: SourceEditController.MediaTypeLists.map(
                        (t) => DropdownMenuItem(
                            value: t,
                            child: Text(
                              SourceEditController.MediaTypeStrings(
                                  context)[t.index],
                            ))).toList(),
                    value: parse.mediaType,
                    onChanged: (v) => setState(() => parse.mediaType = v),
                  ),
                ),
              ))
              ..add(SettingDevideText(S.of(context).Agent_Settings))
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

  static List<String> MediaTypeStrings(BuildContext context) {
    return [
      S.of(context).Article,
      S.of(context).Video,
      S.of(context).Image,
      S.of(context).Sound,
    ];
  }

  SourceEditController() {
//    this.parse = this.parse ?? BaseParse(List(ParseType.All.index));
  }
}
