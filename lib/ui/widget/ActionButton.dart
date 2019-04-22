import 'package:flutter/material.dart';

class ActionButton {
  String name = "";
  IconData icon = Icons.texture;
  dynamic action;
  bool hide = false;
  bool devide = false;

  ActionButton(
      {@required this.name,
      @required this.icon,
      this.action,
      this.devide,
      this.hide}) {
    this.hide = this.hide ?? false;
  }
}
