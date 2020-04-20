import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';

class BuyDetailPage extends StatefulWidget {
  final BuyItem buyItem;

  const BuyDetailPage({Key key, this.buyItem}) : super(key: key);

  @override
  _BuyDetailPageState createState() => _BuyDetailPageState();
}

class _BuyDetailPageState extends State<BuyDetailPage> {
  BuyItem item;

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    item = widget.buyItem;
    controller = TextEditingController();
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
    List<Widget> widgets = common();
    switch (item.status) {
      case 0:
        widgets.addAll(status0());
        break;
      case 1:
        widgets.addAll(status1());
        break;
      case 2:
        widgets.addAll(status2());
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
    }
    return widgets;
  }

  List<Widget> common() {
    List<Widget> widgets = [
      ListTile(
        title: Text(
          '订单号:',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      ListTile(
        title: Text('${item.serialNo}'),
        trailing: InkWell(
          onTap: () {},
          child: Text(
            '复制',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      ListTile(
          title: Text.rich(TextSpan(
        text: '创建日期  ',
        style: TextStyle(color: Colors.blue),
        children: [
          TextSpan(
            text: '${item.created}',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ))
          //Text('创建日期：${item.created}'),
          ),
      ListTile(
        title: Text.rich(TextSpan(
          text: '数量 ',
          style: TextStyle(color: Colors.blue),
          children: [
            TextSpan(
                text: '${item.number}  ',
                style: TextStyle(color: Colors.green)),
            TextSpan(text: '价格 ', style: TextStyle(color: Colors.blue)),
            TextSpan(
                text: '${item.price}', style: TextStyle(color: Colors.green)),
          ],
        )),
        trailing: Text('${item.statusDesc}'),
      ),
      Divider(),
    ];
    return widgets;
  }

  /// 出售中
  List<Widget> status0() {
    return [
      ListTile(
        trailing: FlatButton(
          onPressed: () {},
          child: Text(
            '取消',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.grey,
          shape: WidgetStyle.roundedBorder(circular: 20),
        ),
      )
    ];
  }

  /// 待付款
  List<Widget> status1() {
    var blueTextStyle = WidgetStyle.blueStyle;

    var greenTextStyle = WidgetStyle.greenStyle;
    List<Widget> widgets = [];

    widgets.add(ListTile(
      title: Text.rich(
        TextSpan(text: '联系人：', style: TextStyle(color: Colors.blue), children: [
          TextSpan(
            text: '${item.records.user}',
            style: TextStyle(color: Colors.green),
          ),
        ]),
      ),
    ));
    widgets.add(ListTile(
      title: Text('支付信息'),
    ));

    widgets.addAll(item.records.pays.map((pay) {
      return ListTile(
        isThreeLine: true,
        title: Text(
          '${pay.user}',
          style: blueTextStyle,
        ),
        subtitle: Text.rich(
          TextSpan(
            text: '账号：',
            style: blueTextStyle,
            children: [
              TextSpan(
                text: '${pay.number}',
                style: greenTextStyle,
              ),
              TextSpan(
                text: '\n支付方式: ',
                style: blueTextStyle,
              ),
              TextSpan(
                text: '${pay.typeDesc}',
                style: greenTextStyle,
              ),
            ],
          ),
        ),
        trailing: InkWell(
          child: Text(
            '复制',
            style: blueTextStyle,
            textAlign: TextAlign.end,
          ),
          onTap: () {
            WidgetStyle.copyContent(pay.number);
          },
        ),
      );
    }).toList());
    widgets.add(Divider());

    widgets.addAll([
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
    ]);

    return widgets;
  }

  List<Widget> status2() {
    return [
      ListTile(
        title: Text(
          '支付信息',
          style: WidgetStyle.blueStyle,
        ),
        subtitle: Text('${item.records.detail}'),
        trailing: InkWell(
          child: Text(
            '复制',
            style: WidgetStyle.blueStyle,
          ),
          onTap: () {
            WidgetStyle.copyContent(item.records.detail);
          },
        ),
      ),
      ListTile(
        title: Text.rich(
          TextSpan(
              text: '联系人：',
              style: TextStyle(color: Colors.blue),
              children: [
                TextSpan(
                  text: '${item.records.user}',
                  style: TextStyle(color: Colors.green),
                ),
              ]),
        ),
        trailing: InkWell(
          child: Text(
            '复制',
            style: WidgetStyle.blueStyle,
          ),
          onTap: () {
            WidgetStyle.copyContent(item.records.user);
          },
        ),
      ),
      Divider(),
    ];
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
                  String errorString;
                  if (controller.text == null || controller.text.length == 0) {
                    errorString = '请输入正确的支付单号';
                  } else {
                    errorString = null;
                  }

                  if (errorString != null) {
                    alertDialog(context, content: errorString);
                    return;
                  }
                  TradeService.buyFill(
                    item.records.serialNo,
                    controller.text,
                  ).then((value) {
                    if (value.statusCode == 201) {
                      Navigator.of(context).pop();
                      item = BuyItem.fromJson(value.data);
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
}
