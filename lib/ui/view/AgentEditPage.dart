import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../parse/Parse.dart';
import '../model/SourceEditPageModel.dart';

class AgentEditPage extends StatefulWidget {
  final ParseType parseType;

  AgentEditPage(this.parseType, {Key key})
      : assert(parseType != null),
        super(key: key);

  @override
  AgentEditPageState createState() => AgentEditPageState(this.parseType);
}

class AgentEditPageState extends StateMVC {
  final ParseType parseType;

  AgentEditPageState(this.parseType) : super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${Parse.ParseTypeStrings[parseType.index]} Agents Edit"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: <Widget>[]
          ..add(Container(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              color: Theme.of(context).primaryColorLight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(SourceEditPageModel.of(context).name),
                ],
              )))
          ..addAll(SourceEditPageModel.of(context)
              .agents[parseType.index]
              .map((agent) => ListTile(
                    title: Text(agent.name),
                    subtitle: Text(agent.UUID),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ))),
      ),
    );
  }
}
