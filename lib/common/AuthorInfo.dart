import 'dart:convert';

import 'Info.dart';

class AuthorInfo implements Info {
  String name;
  String email;
  String phone;
  String donate_message;
  String donate_url;

  AuthorInfo(
      {this.donate_message = "donate",
      this.donate_url = "",
      this.email = "",
      this.name = "feilong",
      this.phone = ""});

  /// jsonKeys
  static const String jsonKey_Name = "name";
  static const String jsonKey_Email = "email";
  static const String jsonKey_Phone = "phone";
  static const String jsonKey_DonateMessage = "dmsg";
  static const String jsonKey_DonateUrl = "durl";

  static AuthorInfo fromJson(Map<String, dynamic> jsonObj) {
    return AuthorInfo(
      name: jsonObj[jsonKey_Name],
      email: jsonObj[jsonKey_Email],
      phone: jsonObj[jsonKey_Phone],
      donate_message: jsonObj[jsonKey_DonateMessage],
      donate_url: jsonObj[jsonKey_DonateUrl],
    );
  }

  static AuthorInfo fromString(String str) {
    return fromJson(json.decode(str));
  }

  Map<String, dynamic> toJson() {
    return {
      jsonKey_Name: name,
      jsonKey_Email: email,
      jsonKey_Phone: phone,
      jsonKey_DonateMessage: donate_message,
      jsonKey_DonateUrl: donate_url,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
