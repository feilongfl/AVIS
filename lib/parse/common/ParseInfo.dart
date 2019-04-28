import 'dart:convert';

import '../../common/AuthorInfo.dart';
import '../../common/Info.dart';

class ParseInfo implements Info{
  // .* (.*?);
  String uuid;
  String name;
  String url;
  AuthorInfo author;
  String version_number;
  String update_url;
  String comment;

  // this.$1,
  ParseInfo({
    this.uuid,
    this.name,
    this.url,
    this.author,
    this.version_number,
    this.update_url,
    this.comment,
  });

  // static const jsonKey_$1 = "$1";
  static const jsonKey_uuid = "uuid";
  static const jsonKey_name = "name";
  static const jsonKey_url = "url";
  static const jsonKey_author = "author";
  static const jsonKey_version_number = "version_number";
  static const jsonKey_update_url = "update_url";
  static const jsonKey_comment = "comment";

  static ParseInfo fromJson(Map<String, dynamic> jsonObj) {
    return ParseInfo(
      // $1: jsonObj[jsonKey_$1],
      uuid: jsonObj[jsonKey_uuid],
      name: jsonObj[jsonKey_name],
      url: jsonObj[jsonKey_url],
      author: AuthorInfo.fromString(jsonObj[jsonKey_author]),
      version_number: jsonObj[jsonKey_version_number],
      update_url: jsonObj[jsonKey_update_url],
      comment: jsonObj[jsonKey_comment],
    );
  }

  static ParseInfo fromString(String str) {
    return fromJson(json.decode(str));
  }

  Map<String, dynamic> toJson() {
    return {
      // jsonKey_$1: $1,
      jsonKey_uuid: uuid,
      jsonKey_name: name,
      jsonKey_url: url,
      jsonKey_author: author.toString(),
      jsonKey_version_number: version_number,
      jsonKey_update_url: update_url,
      jsonKey_comment: comment,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
