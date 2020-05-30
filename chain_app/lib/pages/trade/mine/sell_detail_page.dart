import 'package:chain_app/models/sell_list.dart';
import 'package:chain_app/pages/trade/widgets/trade_widget.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:chain_app/tools/services/trade_services.dart';
import 'package:chain_app/widgets/images_preview.dart';
import 'package:chain_app/widgets/route_animation.dart';
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
        title: Text.rich(WStyle.blueText('订单号:')),
        trailing: Widgets.copyWidgets(item.serialNo),
      ),
      ListTile(title: Text.rich(WStyle.greenText(item.serialNo))),
      ListTile(
          title: Text.rich(
        WStyle.textSpans([
          WStyle.blueText('创建日期: '),
          WStyle.greenText('${item.created}'),
        ]),
      )),
      ListTile(
          title: Text.rich(WStyle.textSpans([
            WStyle.blueText('数量 '),
            WStyle.greenText('${item.number}'),
            WStyle.blueText(' 单价 '),
            WStyle.greenText('${item.price}'),
            WStyle.blueText(' 总价 '),
            WStyle.greenText('${item.price * item.number}')
          ])),
          trailing: Text(
            '${item.statusDesc}',
            style: WStyle.green,
          )),
    ];

    return wid;
  }

  /// 基础信息
  List<Widget> status0() {
    return [
      ListTile(
        trailing: TradeWidget.cancelWidget(callback: () {
          TradeService.sellCancel(item.serialNo).then((value) {
            int code = value.statusCode;
            if  (code == 202) {
              SManager.showMessage('取消成功');
              item = SellItem.fromJson(value.data);
              setState(() {

              });
            } else {
              SManager.showMessage(value.data.toString());
            }
          }).catchError((error) {
            SManager.dioErrorHandle(context, error);
          });
        }),
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
    String urls = NServices.imageUrl(item.detail);
    return [
      TradeWidget.payWidget(urls, onTap: () {
        Navigator.of(context)
            .push(RouteAnimation(ImagePreview(images: [urls])));
      }),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: TradeWidget.receivedWidget(
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
                                alertDialog(context, content: value.data.toString());
                              }
                            }).catchError((error) {
                              SManager.dioErrorHandle(context, error);
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
            ),
          ),
          Center(child: TradeWidget.objectionWidget(onPressed: () {}))
        ],
      ),
      TradeWidget.confirmTips(),
    ];
  }

  /// 完成
  List<Widget> status3() {
    List<Widget> wid = [];

    return wid;
  }

  /// 取消
  List<Widget> status4() {
    List<Widget> wid = [];

    return wid;
  }
}
