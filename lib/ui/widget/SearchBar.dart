import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends StateMVC {
  @override
  Widget build(BuildContext context) {
    return Container(
//        color: Colors.amber,
//        padding: EdgeInsets.only(left: 10) ,
        child: Row(
      children: <Widget>[
//            IconButton(
//                icon:
//                Icon(_SearchBarControl.isInput ? Icons.arrow_back : Icons.dehaze),
//                onPressed: _SearchBarControl.isInput
//                    ? _SearchBarControl.CancleInput
//                    : _SearchBarControl.ShowNav),
        Flexible(
          child: TextField(
            onTap: () {
              setState(_SearchBarControl.StartInput);
            },
            onEditingComplete: () {
              setState(_SearchBarControl.FinishInput);
            },
            controller: _SearchBarControl.controller,
            decoration: new InputDecoration(
              hintText: _SearchBarControl.defaultInputString,
            ),
          ),
        ),
        IconButton(icon: Icon(Icons.keyboard_voice), onPressed: null),
      ],
    ));
  }
}

class _SearchBarControl extends ControllerMVC {
  static bool _isInput = false;
  static String defaultInputString = "Search";

  static bool get isInput => _isInput;
  static TextEditingController _controller = new TextEditingController();

  static TextEditingController get controller => _controller;

  static void StartInput() {
    _isInput = true;
  }

  static void FinishInput() {
    _isInput = false;
  }

  static void ShowNav() {}

  static void CancleInput() {}
}
