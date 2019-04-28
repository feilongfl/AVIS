import 'package:flutter/material.dart';

import '../homepage/HomepageTabItem.dart';

class HomepageTabItemEdit extends StatelessWidget {
  HomepageTabItem item;

  HomepageTabItemEdit({this.item}) {
    this.item = this.item ?? HomepageTabItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage Tab Item Edit"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => Navigator.of(context).pop(item),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[]..add(ListTile(
            title: Text(item.name),
          )),
      ),
    );
  }
}
