import 'package:flutter/material.dart';

class RouteButton {
  String name = "";
  IconData icon = Icons.texture;
  String route = "/";
  bool devide = false;
  dynamic argument;

  RouteButton({this.name, this.icon, this.route, this.devide, this.argument});

  void nav(BuildContext context) {
    Navigator.of(context).pushNamed(this.route, arguments: argument);
  }
}
