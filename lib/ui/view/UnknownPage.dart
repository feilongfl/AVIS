import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class UnknownPage extends StatefulWidget {
  UnknownPage({Key key}) : super(key: key);

  @override
  _UnknownPageState createState() => _UnknownPageState();
}

class _UnknownPageState extends StateMVC{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("404"),),
      body: Center(child: Text("404"),),
    );
  }
}