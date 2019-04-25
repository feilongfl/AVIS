class ParseJsonKey {
  // normal
  static const String UUID = "P_UUID";
  static const String NAME = "P_NAME";
  static const String URL = "P_URL";
  static const String COMMENT = "P_COMMENT";
  static const String UPDATEURL = "P_UPDATEURL";
  static const String TYPE = "P_TYPE";

  // author
  static const String AUTHOR = "PU_AUTHOR";
  static const String AUTHOR_EMAIL = "PU_EMAIL";
  static const String AUTHOR_WEBSITE = "PU_WEB";

  // AGENT
  static const String AGENT_SEARCH = "PA_SEARCH";
  static const String AGENT_INFO = "PA_INFO";
  static const String AGENT_EPISODE = "PA_EPISODE";
  static const String AGENT_CHAPTER = "PA_CHAPTER";
  static const String AGENT_SOURCE = "PA_SOURCE";
  static const String AGENT_SOURCELAZY = "PA_SOURCELAZY";
  static const String AGENT_HOMEPAGE = "PA_HOMEPAGE";
  static const String AGENT_LOGIN = "PA_LOGIN";

  static const List<String> AGENT_JSONKEYS = [
    ParseJsonKey.AGENT_SEARCH,
    ParseJsonKey.AGENT_INFO,
    ParseJsonKey.AGENT_EPISODE,
    ParseJsonKey.AGENT_CHAPTER,
    ParseJsonKey.AGENT_SOURCE,
    ParseJsonKey.AGENT_SOURCELAZY,
    ParseJsonKey.AGENT_HOMEPAGE,
    ParseJsonKey.AGENT_LOGIN,
  ];
}
