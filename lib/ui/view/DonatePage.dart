import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/AppRoutes.dart';
import '../../generated/i18n.dart';

class DonatePage extends StatelessWidget {
  void _itemClick(
      BuildContext context, _DonateItem item, GlobalKey<ScaffoldState> key) {
    if (item.url != null) {
      AppRoutes.LaunchURL(item.url);
    } else {
      Clipboard.setData(new ClipboardData(text: item.account));

      key.currentState.showSnackBar(new SnackBar(
        content: new Text(S.of(context).tip_copied_account),
      ));
    }
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      color: Theme.of(context).primaryColorLight,
      child: Text(
        S.of(context).Donate,
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
        title: Text(S.of(context).Donate),
      ),
      body: ListView(
        children: <Widget>[]
              ..add(_header(context))
              ..addAll(_DonateData().WebSite(context).map((v) => ListTile(
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
  List<_DonateItem> WebSite(BuildContext context) {
    return [
      _DonateItem(S.of(context).AliPay, S.of(context).AliPay_feilong, null),
      _DonateItem(S.of(context).WeChat, S.of(context).WeChat_feilong, null),
      _DonateItem(S.of(context).Paypal, S.of(context).Paypal_feilong,
          S.of(context).Paypal_feilong),
    ];
  }
}
