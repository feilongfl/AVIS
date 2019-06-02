import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'Info.dart';

part 'AuthorInfo.g.dart';

@JsonSerializable(nullable: false)
class AuthorInfo implements Info {
  String name;
  String email;
  String phone;
  String donateMessage;
  String donateUrl;

  AuthorInfo(
      {this.donateMessage = "donate",
      this.donateUrl = "",
      this.email = "",
      this.name = "feilong",
      this.phone = ""});

  factory AuthorInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthorInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorInfoToJson(this);

  factory AuthorInfo.fromString(String str) {
    return AuthorInfo.fromJson(json.decode(str));
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
