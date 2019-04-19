import 'dart:io';

import '../Agent/Agent.dart';
import '../Agent/HttpAgent.dart';
import '../common/AppEnums.dart';
import '../core/HTTP.dart';
import '../event/Event.dart';
import '../media/Media.dart';
import 'Parse.dart';

class DemoHttpParse implements Parse {
  static String ParseUUID = "76c1ae48-81b8-42e3-a868-d69cf2f2ea5d";
  static String name = "DemoHttpParse";

  static MediaType type = MediaType.Image;

  List<List<Agent>> agents = new List(ParseType.All.index);

  HttpClient httpClient = new HttpClient();

  Agent domoAgent = HttpAgent("https://www.50mh.com/list/riben/");

  Future<List<Media>> doWork(ParseType type, Map<String, dynamic> data) async {
    Event eventTrig = Event(data);
    List<Event> events = await domoAgent.doWork(eventTrig);

    ///////////////////////////////////////////////////////////////////
    // fetch net data
    HTTPResult netResult =
        await HTTP.Get(httpClient, "https://www.50mh.com/list/riben/");

    if (netResult.status != HttpStatus.ok) return null;

    // match regex.
    RegExp re = RegExp(
        '<a class="comic_img" href="(.*?)"><img src="(.*?)" alt="(.*?)"');

    return re.allMatches(netResult.body).map((Match m) {
      Media media = Media();
      media.info.title = m.group(3);
      media.info.cover = m.group(2);
      media.info.url = m.group(1);
      return media;
    }).toList();
  }
}
