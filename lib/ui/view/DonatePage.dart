import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/AppRoutes.dart';

class DonatePage extends StatelessWidget {
  void _itemClick(
      BuildContext context, _DonateItem item, GlobalKey<ScaffoldState> key) {
    if (item.url != null) {
      AppRoutes.LaunchURL(item.url);
    } else {
      Clipboard.setData(new ClipboardData(text: item.account));

      key.currentState.showSnackBar(new SnackBar(
        content: new Text("Account copied to Clipboard"),
      ));
    }
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      color: Theme.of(context).primaryColorLight,
      child: Text(
        "Donate",
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Donate"),
      ),
      body: ListView(
        children: <Widget>[]
              ..add(_header(context))
              ..addAll(_DonateData.WebSite.map((v) => ListTile(
                    onTap: () => _itemClick(context, v, key),
                    title: Text(v.name),
                    subtitle: Text(v.account),
                  ))) //add
            ,
      ),
    );
  }
}

class _DonateItem {
  final String name;
  final String account;
  final String url;
  final Image pic;

  _DonateItem(this.name, this.account, this.url, {this.pic});
}

class _DonateData {
  static List<_DonateItem> WebSite = [
    _DonateItem("AliPay", "614183595@qq.com", null),
    _DonateItem("WeChat", "feilong_wx", null),
    _DonateItem("Paypal", "https://www.paypal.me/feilongpay",
        "https://www.paypal.me/feilongpay"),
  ];
}
