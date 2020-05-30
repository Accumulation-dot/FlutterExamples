import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/pages/trade/widgets/trade_widget.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:chain_app/tools/services/trade_services.dart';
import 'package:chain_app/widgets/images_preview.dart';
import 'package:chain_app/widgets/route_animation.dart';

import 'package:flutter/material.dart';

class BuyOrderDetailPage extends StatefulWidget {
  final BuyOrder order;

  const BuyOrderDetailPage({Key key, this.order}) : super(key: key);
  @override
  _BuyOrderDetailPageState createState() => _BuyOrderDetailPageState();
}

class _BuyOrderDetailPageState extends State<BuyOrderDetailPage> {
  BuyOrder order;

  TextStyle blue = WStyle.blue;
  TextStyle green = WStyle.green;

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
              text: '  单价  ',
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
    String images = NServices.imageUrl(order.detail);
    List<Widget> widgets = [
      TradeWidget.payWidget(images, onTap: () {
        Navigator.of(context).push(RouteAnimation(ImagePreview(
          images: [images],
        )));
      }),
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
                  alertDialog(context, content: value.data.toString());
                }
              }).catchError((error) {
                SManager.dioErrorHandle(context, error);
              });
            },
            color: Colors.orange,
            child: Text(
              '已收款',
              style: TextStyle(color: Colors.white),
            ),
            shape: WStyle.roundedBorder20,
          ),
//          FlatButton(
//            onPressed: () {},
//            color: Colors.grey,
//            child: Text(
//              '未收款, 对支付单号有异议',
//              style: TextStyle(color: Colors.white),
//            ),
//            shape: WStyle.roundedBorder20,
//          )
          TradeWidget.objectionWidget(onPressed: () {})
        ],
      ),
      TradeWidget.confirmTips(),
    ];
    return widgets;
  }

  List<Widget> status2() {
    return [Divider()];
  }
}
