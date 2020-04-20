import 'package:chain_app/pages/trade/choice.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TradeAddPage extends StatefulWidget {
  final TradeType tradeType;

  const TradeAddPage({Key key, this.tradeType = TradeType.sell})
      : super(key: key);

  @override
  _TradeAddPageState createState() => _TradeAddPageState();
}

class _TradeAddPageState extends State<TradeAddPage> {
  TextEditingController number = TextEditingController();

  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = const EdgeInsets.only(left: 30, top: 10, right: 30);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.help_outline,
                color: Colors.white,
              ),
              onPressed: () {
                alertDialog(context,
                    content:
                        '你发布的交易信息只会出现在app的交易区，供别人查看。\n如果想查看你发布的信息，请去个人主页->我的**信息或者交易区右上角点击查看我的**信息');
              })
        ],
        centerTitle: true,
        title: Text(widget.tradeType == TradeType.buy ? '添加收购信息' : '添加出售信息'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: edgeInsets,
            child: TextField(
              decoration: InputDecoration(
                  labelText: '输入数量', helperText: widget.tradeType == TradeType.sell ? '消耗输入数量1.5倍: 25% 手续费, 25% 购物币(扣入到购物币)': null),
              controller: number,
              enableInteractiveSelection: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: edgeInsets,
            child: TextField(
              controller: price,
              decoration: InputDecoration(labelText: '请输入单价',),
              enableInteractiveSelection: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Text(
                '提交',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: WidgetStyle.roundedBorder(
                circular: 20,
              ),
              color: Colors.orange,
              onPressed: () {
                int n = int.parse(number.text);
                int p = int.parse(price.text);
                if (n == 0 || p == 0) {
                  alertDialog(context, content: '请输入正确的数量和价格!');
                  return;
                }
                switch (widget.tradeType) {
                  case TradeType.sell:
                    {
                      TradeService.addSell(
                        num: n,
                        pri: p,
                      ).then((value) {
                        if (value.statusCode == 201) {
                          Fluttertoast.showToast(msg: '添加成功');
                          if (mounted) {
                            Navigator.of(context)
                                .popAndPushNamed(Routes.sell_mine);
                          }
                        } else {
                          alertDialog(context, content: value.data);
                        }
                      }).catchError((e) {
                        alertDialog(context, content: e.toString());
                      });
                      break;
                    }
                  case TradeType.buy:
                    {
                      TradeService.addBuy(
                        num: n,
                        pri: p,
                      ).then((value) {
                        if (value.statusCode == 201) {
                          Fluttertoast.showToast(msg: '添加成功');
                          if (mounted) {
                            Navigator.of(context)
                                .popAndPushNamed(Routes.buy_mine);
                          }
                        } else {
                          alertDialog(context, content: value.data);
                        }
                      }).catchError((e) {
                        alertDialog(context, content: e.toString());
                      });
                    }
                    break;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
