import 'package:flutter/cupertino.dart';

import '../../generated/i18n.dart';

enum CodecAgent_Method {
  encode,
  decode,
  //all
  all,
}

enum AgentLists {
  HttpAgent,
  RegexpAgent,
  EventFormatAgent,
  Base64Agent,
  UrlCodecsAgent,
  ActAsAgent,
  //all
  All,
}

class AgentConst {
  ////////////////////////////// Agent common //////////////////////////////////

  static const List<AgentLists> AgentItems = [
    AgentLists.HttpAgent,
    AgentLists.RegexpAgent,
    AgentLists.EventFormatAgent,
    AgentLists.Base64Agent,
    AgentLists.UrlCodecsAgent,
  ];
  static const List<String> AgentItemNames = [
    "Http Agent",
    "Regexp Agent",
    "Event Format Agent",
    "Base64 Agent",
    "Url Codecs Agent"
  ];

  ////////////////////////////// Agent common //////////////////////////////////

  ////////////////////////////// Normal Codecs Agent //////////////////////////////////
  static const List<CodecAgent_Method> CodecsMethods = [
    CodecAgent_Method.encode,
    CodecAgent_Method.decode,
  ];

  static List<String> codecsMethodStrings(BuildContext context) => [
        S.of(context).Agent_Codec_Method_encode,
        S.of(context).Agent_Codec_Method_decode,
      ];
////////////////////////////// Normal Codecs  Agent //////////////////////////////////

}
