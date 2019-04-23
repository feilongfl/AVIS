import 'dart:io';

import '../common/AppEnums.dart';
import '../common/AppShareData.dart';
import '../core/HTTP.dart';
import '../event/Event.dart';
import 'Agent.dart';
import 'BaseAgent.dart';

class HttpAgent extends BaseAgent {
  String name = "HttpAgent";
//  String _UUID = "";
  DateTime lastRun = Agent.DefaultDateTime;
  final String AgentUUID = "c8d639f3-fbf7-4575-bbd2-0a3945446ff9";

  HttpMethod method = HttpMethod.Get;
  String userAgent = HttpUserAgent.Linux_Chrome;
  String postData;
  String cookies;
  String referer;
  String url = "";

  HttpClient httpClient = new HttpClient();

  String get UUID => AgentUUID;

  List<String> replaces = new List();

  HttpAgent(
      {this.url,
      this.lastRun,
      this.cookies,
      this.method,
      this.postData,
      this.referer,
      this.userAgent,
      this.replaces})
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
}
