import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../common/AppEnums.dart';
import '../common/AppShareData.dart';
import '../core/HTTP.dart';
import '../event/Event.dart';
import '../ui/widget/SettingDivideText.dart';
import 'Agent.dart';
import 'BaseAgent.dart';

class HttpAgent extends BaseAgent {
  String name = "HttpAgent";

//  String _UUID = "";
  DateTime lastRun = Agent.DefaultDateTime;
  final String AgentUUID = "c8d639f3-fbf7-4575-bbd2-0a3945446ff9";

  final AgentLists agentType = AgentLists.HttpAgent;

  HttpMethod method = HttpMethod.Get;
  String userAgent = HttpUserAgent.Linux_Chrome;
  String postData;
  String cookies;
  String referer;
  String url = "";

  static const List<HttpMethod> HttpMethods = [
    HttpMethod.Get,
//    HttpMethod.Post,
//    HttpMethod.Put,
//    HttpMethod.Delete,
  ];

  static const List<String> HttpMethodStrings = [
    "Get",
    "Post",
    "Put",
    "Delete"
  ];

  HttpClient httpClient = new HttpClient();

  String get UUID => AgentUUID;

//  List<String> replaces = Event.EventItemStrings;

  HttpAgent(
      {this.url = "https://feilong.home.blog",
      this.lastRun,
      this.cookies,
      this.method = HttpMethod.Get,
      this.postData = "",
      this.referer,
      this.userAgent = HttpUserAgent.Linux_Chrome,
//      this.replaces
      })
      : super();

  @override
  Future<List<Event>> doRealWork(Event eventIn) async {
    List<Event> eventOut = await super.doRealWork(eventIn);

    HTTPResult httpResult = await HTTP.work(
      httpClient,
      this.ReplaceOneVal(eventIn.Data[Event.Url] ?? this.url, eventIn), //url
      referer: eventIn.Data[Event.Referer] ?? this.referer,
      useragent: eventIn.Data[Event.Useragent] ?? this.userAgent,
      cookies: eventIn.Data[Event.Cookies] ?? this.cookies,
      method: eventIn.Data[Event.HttpMethod] ?? this.method,
      data: this.ReplaceOneVal(this.postData, eventIn),
    );

    eventOut[0].Data[Event.Body] = httpResult.body;
    eventOut[0].success = httpResult.status == HttpStatus.ok;

    return eventOut;
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    if (AgentUUID != json['AgentUUID']) return;

//    this._UUID = json['UUID'];
    this.lastRun = json['lastRun'];
    this.method = json['method'];
    this.userAgent = json['userAgent'];
    this.postData = json['postData'];
    this.cookies = json['cookies'];
    this.referer = json['referer'];
    this.url = json['url'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['UUID'] = this.UUID;
    data['lastRun'] = this.lastRun;
    data['cookies'] = this.cookies;
    data['method'] = this.method;
    data['postData'] = this.postData;
    data['referer'] = this.referer;
    data['userAgent'] = this.userAgent;
    data['url'] = this.url;

    return data;
  }

  Widget AgentConfigPage(Agent agent) => _AgentConfigPage(agent);
}

class _AgentConfigPage extends StatefulWidget {
  final Agent agent;

  _AgentConfigPage(this.agent, {Key key}) : super(key: key);

  @override
  _AgentConfigPageState createState() => _AgentConfigPageState(agent);
}

class _AgentConfigPageState extends StateMVC {
  final HttpAgent agent;
  var _formKey = GlobalKey<FormState>();

  _AgentConfigPageState(this.agent)
      : assert(agent.agentType == AgentLists.HttpAgent),
        super();

  void _saveAndPop() {
    _formKey.currentState.save();
    Navigator.of(context).pop(agent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${agent.name} Config"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveAndPop,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
            children: <Widget>[]
              ..add(SettingDevideText("Base Http"))
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: "Url"),
                    onSaved: (v) => setState(() => agent.url = v),
                    initialValue: agent.url,
                  ),
                ),
              )
              ..add(ListTile(
//                  leading: Text("Http Method:"),
                  title: DropdownButtonFormField<HttpMethod>(
                      value: agent.method,
                      onChanged: (v) => setState(() => agent.method = v),
                      decoration: InputDecoration(labelText: "Http Method"),
                      items: HttpAgent.HttpMethods.map((v) => DropdownMenuItem(
                              value: v,
                              child:
                                  Text(HttpAgent.HttpMethodStrings[v.index])))
                          .toList())))
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: "User Agent"),
                    onSaved: (v) => setState(() => agent.userAgent = v),
                    initialValue: agent.userAgent,
                  ),
                ),
              )
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: "Referer"),
                    onSaved: (v) => setState(() => agent.referer = v),
                    initialValue: agent.referer ?? "",
                  ),
                ),
              )
//              ..add(
//                ListTile(
//                  title: TextFormField(
//                    decoration: InputDecoration(labelText: "Post Data"),
//                    onSaved: (v) => setState(() => agent.postData = v),
//                    initialValue: agent.postData ?? "",
//                  ),
//                ),
//              )
              ..add(
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: "Cookies"),
                    onSaved: (v) => setState(() => agent.cookies = v),
                    initialValue: agent.cookies ?? "",
                  ),
                ),
              )
//              ..add(SettingDevideText("Match Group"))
            ),
      ),
    );
  }
}
