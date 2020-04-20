import 'dart:math';

import 'package:chain_app/models/sell_list.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellDetailPage extends StatefulWidget {
  final SellItem sellItem;

  const SellDetailPage({Key key, this.sellItem}) : super(key: key);

  @override
  _SellDetailPageState createState() => _SellDetailPageState();
}

class _SellDetailPageState extends State<SellDetailPage> {
  SellItem item;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.sellItem;
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
    var temp = common();
    switch (item.status) {
      case 0:
        temp.addAll(status0());
        break;
      case 1:
        temp.addAll(status1());
        break;
      case 2:
        temp.addAll(status2());
        break;
      case 3:
        temp.addAll(status3());
        break;
      case 4:
        temp.addAll(status4());
        break;
      default:
        break;
    }
    return temp;
  }

  List<Widget> common() {
    List<Widget> wid = [
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
    ];

    return wid;
  }

  /// 基础信息
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

  /// 被某人预定
  List<Widget> status1() {
    List<Widget> wid = [];

    return wid;
  }

  /// 某人已付款
  List<Widget> status2() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: FlatButton(
              child: Text(
                '确认收款',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.orangeAccent,
              onPressed: () {
                alertDialog(context,
                    content: '请确认你已经收到转账，否则确认后币不可找回?',
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            TradeService.sellConfirm(item.serialNo)
                                .then((value) {
                              if (value.statusCode == 202) {
                                item = SellItem.fromJson(value.data);
                                setState(() {});
                              } else {
                                alertDialog(context, content: value.data);
                              }
                            }).catchError((e) {
                              alertDialog(context, content: e.toString());
                            });
                          },
                          child: Text('确定')),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('取消'),
                      )
                    ]);
              },
              shape: WidgetStyle.roundedBorder(circular: 20),
            ),
          ),
          Center(
            child: FlatButton(
                onPressed: () {},
                child: FlatButton(
                  child: Text(
                    '未收到款',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                  onPressed: () {},
                  shape: WidgetStyle.roundedBorder(circular: 20),
                )),
          )
        ],
      )
    ];
  }

  /// 完成
  List<Widget> status3() {
    List<Widget> wid = [
//      ListTile(title: Text('${item.detail}'),)
    ];

    return wid;
  }

  /// 取消
  List<Widget> status4() {
    List<Widget> wid = [];

    return wid;
  }
}
