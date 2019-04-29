import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../common/AppRoutes.dart';
import '../../../common/AppShareData.dart';
import '../../../generated/i18n.dart';
import '../../../parse/common/Parse.dart';
import '../../../parse/common/ParseConst.dart';
import '../../widget/SettingDivideText.dart';

class SourceSettingPage extends StatefulWidget {
  @override
  SourceSettingState createState() => SourceSettingState();
}

class SourceSettingState extends StateMVC {
  void _editParse(Parse parse) {}

  Widget _tile(BuildContext context, Parse parse) {
    return ListTile(
      onTap: () => AppRoutes.launchURL(parse.info.url ?? ""),
      title: Text(parse.info.name ?? "name"),
      subtitle: Text(
        (parse.info.url ?? "")
            .replaceFirst("https://", "")
            .replaceFirst("http://", ""),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: parse.type == ParseType.Source
          ? Icon([
              Icons.translate,
              Icons.video_library,
              Icons.image,
              Icons.surround_sound
            ][parse.mediaType.index])
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Edit",
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.SourceEdit, arguments: parse)
                .then((p) => AppShareData.of(context).addOrEditAppParse(p)),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: "Delete",
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Confirm Delete ${parse.info.name}"),
                        content: Text("UUID: " + parse.info.uuid),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () =>
                                Navigator.of(context).pop("Cancle"),
                            child: Text("Cancle"),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop("OK"),
                            child: Text("Delete"),
                          ),
                        ],
                      )).then((returnValue) {
                switch (returnValue) {
                  case "OK":
                    setState(() => AppShareData.of(context).removeParse(parse));
                    break;

                  default:
                    break;
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: "About",
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(parse.info.author.name),
                        content: Column(
                          children: <Widget>[
                            Text(parse.info.author.email),
                            Text(parse.info.author.donateUrl),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("OK"),
                          ),
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }

//  List<Widget> _group(
//      BuildContext context, String groupName, MediaType mediaType) {
//    List<Widget> widgets = new List();
//
//    widgets.add(SettingDevideText(groupName));
//
//    List<Parse> parses = AppShareData.of(context)
//        .AppParse
//        .where((p) => mediaType == p.mediaType)
//        .toList();
//    if ((parses ?? List()).length > 0)
//      widgets.addAll(parses.map((parse) => _tile(context, parse)));
//    else
//      widgets.add(ListTile(title: Text(S.of(context).NULL)));
//
//    return widgets;
//  }

  List<Widget> _onParseType(
      BuildContext context, String groupName, ParseType parseType) {
    List<Widget> widgets = new List();

    widgets.add(SettingDevideText(groupName));

    List<Parse> parses = AppShareData.of(context)
        .appParse
        .where((p) => parseType == p.type)
        .toList();
    if ((parses ?? List()).length > 0)
      widgets.addAll(parses.map((parse) => _tile(context, parse)));
    else
      widgets.add(ListTile(title: Text(S.of(context).NULL)));

    return widgets;
  }

  List<Widget> _group(BuildContext context, List<String> groupName) {
    assert(groupName.length >= ParseType.All.index);

    List<Widget> widgets = List();
    for (int i = 0; i < ParseType.All.index; i++) {
      widgets.addAll(_onParseType(context, groupName[i], ParseType.values[i]));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Sources),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(AppRoutes.SourceEdit, arguments: null)
            .then((p) => AppShareData.of(context).addOrEditAppParse(p)),
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: []
          ..add(Container(
            color: Theme.of(context).primaryColorLight,
            padding: MediaQuery.of(context).orientation == Orientation.landscape
                ? EdgeInsets.only(top: 30, bottom: 20)
                : EdgeInsets.only(top: 160, bottom: 130),
            child: Column(
              children: <Widget>[
                Text(
                  S.of(context).Sources,
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ))
          ..addAll(
              _group(context, ["Source", "scraper", "subtitle", "weather"])),
      ),
    );
  }
}
