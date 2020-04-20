import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';

class BuyOrderDetailPage extends StatefulWidget {
  final BuyOrder order;

  const BuyOrderDetailPage({Key key, this.order}) : super(key: key);
  @override
  _BuyOrderDetailPageState createState() => _BuyOrderDetailPageState();
}

class _BuyOrderDetailPageState extends State<BuyOrderDetailPage> {
  BuyOrder order;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
        centerTitle: true,
      ),
      body: ListView(
        children: children(),
      ),
    );
  }

  List<Widget> children() {
    List widgets = common();
    switch (order.status) {
      case 0:
        break;
      case 1:
        widgets.addAll(status1());
        break;
      case 2:
        widgets.addAll(status2());
        break;
    }
    return widgets;
  }

  common() {
    List<Widget> widgets = [];

    var blue = WidgetStyle.blueStyle;
    var green = WidgetStyle.greenStyle;

    widgets.add(ListTile(
      title: Text.rich(
        TextSpan(
          text: '联系方式: ',
          style: blue,
          children: [
            TextSpan(
              text: '${order.status == 2 ? '*******' : order.buy.user}',
              style: green,
            ),
          ],
        ),
      ),
    ));

    widgets.add(ListTile(
      title: Text(
        '交易单号',
        style: blue,
      ),
      subtitle: Text(
        '${order.serialNo}',
        style: green,
      ),
    ));

    widgets.add(Divider());
    widgets.add(ListTile(
      title: Text.rich(
        TextSpan(
          text: '数量  ',
          style: blue,
          children: [
            TextSpan(
              text: '${order.buy.number}',
              style: green,
            ),
            TextSpan(
              text: '  价格  ',
              style: blue,
            ),
            TextSpan(
              text: '${order.buy.price}',
              style: green,
            ),
          ],
        ),
      ),
      trailing: Text.rich(
        TextSpan(
          text: '总价：',
          style: blue,
          children: [
            TextSpan(
              text: '${order.buy.number * order.buy.price}',
              style: green,
            ),
          ],
        ),
      ),
    ));

    widgets.add(ListTile(
      title: Text(
        '订单状态',
        style: blue,
      ),
      trailing: Text(
        '${order.statusDesc}',
        textAlign: TextAlign.end,
      ),
    ));
    return widgets;
  }

  List<Widget> status1() {
    List<Widget> widgets = [
      ListTile(
        title: Text.rich(
          TextSpan(text: '支付单号:', style: WidgetStyle.blueStyle, children: [
            TextSpan(text: order.detail, style: WidgetStyle.greenStyle)
          ]),
        ),
        trailing: WidgetStyle.copyWidget(order.detail),
      ),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              TradeService.buyOrderConfirm(order.serialNo).then((value) {
                if (value.statusCode == 202) {
                  order = BuyOrder.fromJson(value.data);
                  setState(() {});
                } else {
                  alertDialog(context, content: value.data);
                }
              }).catchError((onError) {
                alertDialog(context, content: onError.toString());
              });
            },
            color: Colors.orange,
            child: Text(
              '已收款',
              style: TextStyle(color: Colors.white),
            ),
            shape: WidgetStyle.roundedBorder(circular: 20),
          ),
          FlatButton(
            onPressed: () {},
            color: Colors.grey,
            child: Text(
              '未收款, 对支付单号有异议',
              style: TextStyle(color: Colors.white),
            ),
            shape: WidgetStyle.roundedBorder(circular: 20),
          )
        ],
      ),
      Text(
        'tips:如果已收到支付款请点击已收款，\n如果未收到款请点击未收款对支付订单有异议！',
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        textAlign: TextAlign.end,
      )
    ];
    return widgets;
  }

  List<Widget> status2() {
    List<Widget> widgets = [
      ListTile(
        title: Text.rich(
          TextSpan(text: '支付单号:', style: WidgetStyle.blueStyle, children: [
            TextSpan(text: order.detail, style: WidgetStyle.greenStyle)
          ]),
        ),
        trailing: WidgetStyle.copyWidget(order.detail),
      ),
      Divider(),
    ];

    return widgets;
  }
}
