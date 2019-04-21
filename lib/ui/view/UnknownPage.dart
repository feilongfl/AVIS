import 'package:flutter/material.dart';

class UnknownPage extends StatefulWidget {
  String name;

  UnknownPage(this.name, {Key key}) : super(key: key);

  @override
  _UnknownPageState createState() => _UnknownPageState(this.name);
}

class _UnknownPageState extends State<UnknownPage> {
  String name;

  _UnknownPageState(this.name) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("404"),
      ),
      body: Center(
        child: Text(this.name),
      ),
    );
  }
}
