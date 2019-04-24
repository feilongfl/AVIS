import 'package:flutter/material.dart';

class SettingDevideText extends StatelessWidget {
  final String title;
  final Color color;

  SettingDevideText(this.title, {Key key, this.color})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: this.color?? Theme.of(context).primaryColor),
      )),
    );
  }
}
