import 'package:chain_app/style/w_style.dart';
import 'package:flutter/material.dart';

class TradeWidget {
  static Widget payWidget(String url,
      {VoidCallback onTap,
      Widget title = const Text(
        '支付信息',
        style: WStyle.blue,
      )}) {
    return ListTile(
      title: title,
      trailing: SizedBox(
        width: 50,
        height: 50,
        child: InkWell(
          child: Image(image: NetworkImage(url)),
          onTap: onTap,
        ),
      ),
    );
  }

  static Widget receivedWidget({VoidCallback onPressed}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        '确认收款',
        style: TextStyle(color: Colors.white),
      ),
      color: WStyle.confirmColor,
      shape: WStyle.roundedBorder20,
    );
  }

  static Widget objectionWidget({VoidCallback onPressed}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text('未收款, 对支付单号有异议', style: TextStyle(color: Colors.white)),
      color: Colors.grey,
      shape: WStyle.roundedBorder20,
    );
  }

  static Widget confirmTips() {
    return Text(
      'tips:如果已收到支付款请点击已收款，\n如果未收到款请点击未收款对支付订单有异议！',
      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
      textAlign: TextAlign.end,
    );
  }

  static Widget cancelWidget({VoidCallback callback}) {
    return FlatButton(
      onPressed: callback,
      child: Text(
        '取消',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.grey,
      shape: WStyle.roundedBorder20,
    );
  }
}
