import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../generated/i18n.dart';
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

  Widget _ParseTile(BuildContext context, int index, String uuid) {
    return ListTile(
      title: Text(index.toString()),
      subtitle: Text(uuid),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => setState(() => item.parseUuid.removeAt(index))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage Tab Item Edit"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => Navigator.of(context).pop(item),
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
                ),
              ),
            )
            ..add(SettingDevideText("Home Page Parses"))
            ..addAll(item.parseUuid.length > 0
                ? item.parseUuid
                    .asMap()
                    .map((i, pu) => MapEntry(i, _ParseTile(context, i, pu)))
                    .values
                : [ListTile(title: Text(S.of(context).NULL))])
            ..add(ListTile(
              title: Text("Add"),
              leading: Icon(Icons.add),
              onTap: () =>
                  setState(() => item.parseUuid.add("test")), //todo fix here
            )),
        ),
      ),
    );
  }
}
