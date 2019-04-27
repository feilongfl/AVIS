import 'package:flutter/cupertino.dart';

import '../../generated/i18n.dart';

enum Base64Agent_Method {
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

  ////////////////////////////// Base64 Agent //////////////////////////////////
  static const List<Base64Agent_Method> Base64Methods = [
    Base64Agent_Method.encode,
    Base64Agent_Method.decode,
  ];

  static List<String> Base64MethodStrings(BuildContext context) => [
        S.of(context).Agent_Base64_Method_encode,
        S.of(context).Agent_Base64_Method_decode,
      ];
////////////////////////////// Base64 Agent //////////////////////////////////

}
