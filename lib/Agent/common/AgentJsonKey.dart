class AgentJsonKey {
  // normal
  static const String AgentJsonKey_UUID = 'A_UUID';
  static const String AgentJsonKey_TYPE = 'A_TYPE';
  static const String AgentJsonKey_SAVETO = 'A_SAVETO';

  //http Agent
  static const String AgentJsonKey_URL = 'A_URL';
  static const String AgentJsonKey_METHOD = 'A_METHOD';
  static const String AgentJsonKey_USERAGENT = 'A_USERAGENT';
  static const String AgentJsonKey_POSTDATA = 'A_POSTDATA';
  static const String AgentJsonKey_COOKIES = 'A_COOKIES';
  static const String AgentJsonKey_REFERER = 'A_REFERER';

  //regexp agent
  static const String AgentJsonKey_MATCHBODY = 'A_MATCHBODY';
  static const String AgentJsonKey_REGEXP = 'A_REGEXP';
  static const String AgentJsonKey_MATCHGROUP = 'A_MATCHGROUP';

  //Event format agent
  static const String AgentJsonKey_FindKey = 'A_FINDKEY';
  static const String AgentJsonKey_REPLACETO = 'A_REPLACETO';

  //Base64Agent
  static const String AgentJsonKey_BASE64METHOD = 'A_REPLACETO';
  static const String AgentJsonKey_TEXT = 'A_TEXT';
}
