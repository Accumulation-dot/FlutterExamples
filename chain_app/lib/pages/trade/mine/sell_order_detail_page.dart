import 'package:chain_app/models/sell_order_list.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class SellOrderDetailPage extends StatefulWidget {
  final SellOrder sellOrder;

  const SellOrderDetailPage({Key key, this.sellOrder}) : super(key: key);

  @override
  _SellOrderDetailPageState createState() => _SellOrderDetailPageState();
}

class _SellOrderDetailPageState extends State<SellOrderDetailPage> {
  SellOrder sellOrder;

  TextEditingController controller;

  String errorString;
  @override
  void initState() {
    super.initState();
    sellOrder = widget.sellOrder;
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
    switch (sellOrder.status) {
      case 0:
        {
          List list = common();
          list.addAll(status0());
          return list;
        }
        break;
      case 1:
        {
          List list = common(needPays: false);
          list.addAll(status01());
          return list;
        }
      default:
        {
          List list = common(needPays: false);
          list.addAll(status02());
          return list;
        }
    }
  }

  List<Widget> common({bool needPays = true}) {
    List<Widget> list = [];

    var blue = WidgetStyle.blueStyle;
    var green = WidgetStyle.greenStyle;

    list.add(ListTile(
      title: Text.rich(
        TextSpan(
          text: '联系方式: ',
          style: blue,
          children: [
            TextSpan(
              text:
                  '${sellOrder.status == 2 ? '*******' : sellOrder.sell.user}',
              style: green,
            ),
          ],
        ),
      ),
    ));

    list.add(ListTile(
      title: Text(
        '交易单号',
        style: blue,
      ),
      subtitle: Text(
        '${sellOrder.serialNo}',
        style: green,
      ),
    ));

    list.add(Divider());
    list.add(ListTile(
      title: Text.rich(
        TextSpan(
          text: '数量  ',
          style: blue,
          children: [
            TextSpan(
              text: '${sellOrder.sell.number}',
              style: green,
            ),
            TextSpan(
              text: '  价格  ',
              style: blue,
            ),
            TextSpan(
              text: '${sellOrder.sell.price}',
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
              text: '${sellOrder.sell.number * sellOrder.sell.price}',
              style: green,
            ),
          ],
        ),
      ),
    ));

    list.add(ListTile(
      title: Text(
        '订单状态',
        style: blue,
      ),
      trailing: Text(
        '${sellOrder.statusDesc}',
        textAlign: TextAlign.end,
      ),
    ));
    if (needPays) {
      list.add(Divider());
      list.addAll(sellOrder.sell.pays.map((pay) {
        return ListTile(
          isThreeLine: true,
          title: Text(
            '${pay.user}',
            style: blue,
          ),
          subtitle: Text.rich(
            TextSpan(
              text: '账号：',
              style: blue,
              children: [
                TextSpan(
                  text: '${pay.number}',
                  style: green,
                ),
                TextSpan(
                  text: '\n支付方式: ',
                  style: blue,
                ),
                TextSpan(
                  text: '${pay.typeDesc}',
                  style: green,
                ),
              ],
            ),
          ),
          trailing: InkWell(
            child: Text(
              '复制',
              style: blue,
              textAlign: TextAlign.end,
            ),
            onTap: () {
              _copy(pay.number);
            },
          ),
        );
      }).toList());
    }
    return list;
  }

  status0() {
    List<Widget> list = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
              color: Colors.orange,
              shape: WidgetStyle.roundedBorder(circular: 20),
              onPressed: alertDialog0,
              child: Text(
                '已支付上传凭证',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      Text(
        'tips: 交易凭证提交后不可更改!  ',
        textAlign: TextAlign.end,
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      ),
      Divider(),
    ];

    return list;
  }

  alertDialog0() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '提示',
              textAlign: TextAlign.center,
            ),
            content: Container(
              margin: const EdgeInsets.all(10),
              child: SizedBox(
                width: 300,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: '请输入正确的支付单号', helperText: '交易单号提交成功后不可更改'),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  if (controller.text == null || controller.text.length == 0) {
                    errorString = '请输入正确的支付单号';
                  } else {
                    errorString = null;
                  }

                  if (errorString != null) {
                    alertDialog(context, content: errorString);
                    return;
                  }
                  TradeService.sellFill(
                    sellOrder.serialNo,
                    controller.text,
                  ).then((value) {
                    if (value.statusCode == 201) {
                      Navigator.of(context).pop();
                      sellOrder = SellOrder.fromJson(value.data);
                      setState(() {});
                    } else {
                      alertDialog(context, content: value.data);
                    }
                  }).catchError((onError) {
                    alertDialog(context, content: onError.toString());
                  });
                },
                child: Text('确定'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消'),
              )
            ],
          );
        });
  }

  status01() {
    List<Widget> list = [
      Divider(),
      ListTile(
        title: Text(
          '付款信息',
          style: WidgetStyle.blueStyle,
        ),
        subtitle: Text('${sellOrder.detail}'),
      ),
      Divider()
    ];

    return list;
  }

  status02() {
    List<Widget> list = [
      Divider(),
      ListTile(
        title: Text(
          '付款信息',
          style: WidgetStyle.blueStyle,
        ),
        subtitle: Text('${sellOrder.detail}'),
      ),
      Divider()
    ];

    return list;
  }

  _copy(String text) {
    WidgetStyle.copyContent(text);
  }
}
