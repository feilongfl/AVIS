import 'package:flutter/material.dart';

class SettingDevideText extends StatelessWidget {
  final String title;

  SettingDevideText(this.title, {Key key})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
    );
  }
}
