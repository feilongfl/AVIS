import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../common/AppShareData.dart';
import '../../../generated/i18n.dart';
import '../../../parse/common/ParseConst.dart';
import '../../UiConst.dart';
import '../../widget/SettingDivideText.dart';
import '../homepage/HomepageTabItem.dart';

class HomepageTabItemEdit extends StatefulWidget {
  HomepageTabItem item;

  HomepageTabItemEdit({this.item}) : super();

  @override
  State<StatefulWidget> createState() => HomepageTabItemEditState(item: item);
}

class HomepageTabItemEditState extends StateMVC {
  HomepageTabItem item;
  var _formKey = GlobalKey<FormState>();

  HomepageTabItemEditState({this.item}) : super() {
    this.item = this.item ?? HomepageTabItem();
  }

  Widget _parseTile(BuildContext context, int index, String uuid) {
    if (AppShareData.of(context)
            .appParse
            .where((p) =>
                p.actions[ParseActionType.HomePage.index].agents.length != 0)
            .length ==
        0) {
      return ListTile(
        title: Text("Please add a Source with HomepageAgent!"),
      );
    }

    return ListTile(
      title: DropdownButton(
//          decoration: InputDecoration(labelText: "Source"),
          isExpanded: true,
          value: item.parseUuids[index],
          onChanged: (v) => setState(() => item.parseUuids[index] = v),
          items: AppShareData.of(context)
              .appParse
              .where((p) =>
                  p.actions[ParseActionType.HomePage.index].agents.length != 0)
              .map((p) => DropdownMenuItem(
                  value: p.info.uuid,
                  child: Text(
                    p.info.uuid,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )))
              .toList()),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => setState(() => item.parseUuids.removeAt(index))),
    );
  }

  void _popAndSave(BuildContext context) {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage Tab Item Edit"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _popAndSave(context),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[]
            ..add(SettingDevideText("Normal Config"))
            ..add(
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).Name),
                  initialValue: item.name,
                  onSaved: (v) => item.name = v,
                ),
              ),
            )
            ..add(
              ListTile(
                title: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "View Type"),
                    value: item.viewType,
                    onChanged: (v) => setState(() => item.viewType = v),
                    items: ViewType.values
                        .map((vt) => DropdownMenuItem(
                              child: Text(vt.toString()),
                              value: vt,
                            ))
                        .toList()),
              ),
            )
//            ..add(
//              ListTile(
//                title: Text("Auto Refersh"),
//                trailing: Checkbox(
//                  value: item.autoRefersh,
//                  onChanged: (v) => setState(() => item.autoRefersh = v),
//                ),
//              ),
//            )
            ..add(
              ListTile(
                title: Text("Auto Loadmore"),
                trailing: Checkbox(
                  value: item.autoLoadmore,
                  onChanged: (v) => setState(() => item.autoLoadmore = v),
                ),
              ),
            )
            ..add(SettingDevideText("Home Page Parses"))
            ..addAll(item.parseUuids.length > 0
                ? item.parseUuids
                    .asMap()
                    .map((i, pu) => MapEntry(i, _parseTile(context, i, pu)))
                    .values
                : [ListTile(title: Text(S.of(context).NULL))])
            ..add(ListTile(
              title: Text("Add"),
              leading: Icon(Icons.add),
              onTap: () => setState(() {
                    if (AppShareData.of(context)
                            .appParse
                            .where((p) =>
                                p.actions[ParseActionType.HomePage.index].agents
                                    .length !=
                                0)
                            .length !=
                        0)
                      item.parseUuids.add(AppShareData.of(context)
                          .appParse
                          .firstWhere((p) =>
                              p.type == ParseType.Source &&
                              p.actions[ParseActionType.HomePage.index].agents
                                      .length >
                                  0)
                          .info
                          .uuid);
                  }),
            )),
        ),
      ),
    );
  }
}
