import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../common/AppRoutes.dart';
import '../../common/AppShareData.dart';
import '../../parse/common/Parse.dart';

class SourceSettingPage extends StatefulWidget {
  @override
  SourceSettingState createState() => SourceSettingState();
}

class SourceSettingState extends StateMVC {
  void _editParse(Parse parse) {}

  Widget _tile(BuildContext context, Parse parse) {
    return ListTile(
      onTap: () => AppRoutes.LaunchURL(parse.url ?? ""),
      title: Text(parse.name ?? "name"),
      subtitle: Text(parse.url ?? ""),
//      leading: Icon(Icons.dock),
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
                        title: Text("Confirm Delete ${parse.name}"),
                        content: Text("UUID: " + parse.ParseUUID),
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
                    setState(
                        () => AppShareData.of(context).removeParse(parse));
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
                        title: Text(parse.author),
                        content: Column(
                          children: <Widget>[
                            Text(parse.author_email),
                            Text(parse.author_website),
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

  List<Widget> _group(
      BuildContext context, String groupName, MediaType mediaType) {
    List<Widget> widgets = new List();

    widgets.add(Divider());

    widgets.add(Padding(
      padding: EdgeInsets.only(top: 10, left: 15),
      child: Text(groupName),
    ));

    List<Parse> parses = AppShareData.of(context)
        .AppParse
        .where((p) => mediaType == p.type)
        .toList();
    if ((parses ?? List()).length > 0)
      widgets.addAll(parses.map((parse) => _tile(context, parse)));
    else
      widgets.add(ListTile(title: Text("NULL")));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sources"),
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
                  "Sources",
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ))
          ..addAll(_group(context, "Article", MediaType.Article))
          ..addAll(_group(context, "Video", MediaType.Video))
          ..addAll(_group(context, "Image", MediaType.Image))
          ..addAll(_group(context, "Sound", MediaType.Sound)),
      ),
    );
  }
}
