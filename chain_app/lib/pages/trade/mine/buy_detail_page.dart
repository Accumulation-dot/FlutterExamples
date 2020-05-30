import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/pages/trade/widgets/trade_widget.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:chain_app/tools/services/trade_services.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:chain_app/widgets/images_preview.dart';
import 'package:chain_app/widgets/route_animation.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BuyDetailPage extends StatefulWidget {
  final BuyItem buyItem;

  const BuyDetailPage({Key key, this.buyItem}) : super(key: key);

  @override
  _BuyDetailPageState createState() => _BuyDetailPageState();
}

class _BuyDetailPageState extends State<BuyDetailPage> {
  BuyItem item;

  TextEditingController controller;

  TextStyle blue = WStyle.blue;
  TextStyle green = WStyle.green;

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
          style: blue,
        ),
        trailing: Widgets.copyWidgets(item.serialNo),
      ),
      ListTile(
          title: Text(
        '${item.serialNo}',
        style: WStyle.green,
      )),
      ListTile(
        title: Text.rich(WStyle.textSpans(
            [WStyle.blueText('创建日期：'), WStyle.greenText(item.created)])),
      ),
      ListTile(
        title: Text.rich(WStyle.textSpans(
          [
            WStyle.blueText('数量 '),
            WStyle.greenText('${item.number}'),
            WStyle.blueText('总价 '),
            WStyle.greenText((item.number * item.price).toStringAsFixed(2)),
          ],
        )),
        trailing: Text(
          '${item.statusDesc}',
          style: WStyle.green,
        ),
      ),
      Divider(),
    ];
    return widgets;
  }

  /// 出售中
  List<Widget> status0() {
    return [
      ListTile(
        trailing: TradeWidget.cancelWidget(callback: () {
          TradeService.buyCancel(item.serialNo).then((value) {
            int code = value.statusCode;
            if  (code == 202) {
              SManager.showMessage('取消成功');
              item = BuyItem.fromJson(value.data);
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

  /// 待付款
  List<Widget> status1() {
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
      title: Text(
        '支付信息',
        style: WStyle.blue,
      ),
    ));

    widgets.addAll(item.records.pays.map((pay) {
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
        trailing: Widgets.copyWidgets(pay.number),
      );
    }).toList());
    widgets.add(Divider());

    widgets.addAll([
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
              color: Colors.orange,
              shape: WStyle.roundedBorder20,
              onPressed: _pickerImage,
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

  /// 已经付款
  List<Widget> status2() {
    String urls = NServices.imageUrl(item.records.detail);
    return [
      TradeWidget.payWidget(urls, onTap: () {
        Navigator.of(context).push(
          RouteAnimation(
            ImagePreview(
              images: [urls],
            ),
          ),
        );
      }),
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
        trailing: Widgets.copyWidgets(item.records.user),
      ),
      Divider(),
    ];
  }

  _pickerImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    var compressImage = await Tools.imageCompress(image, item.records.serialNo);

    TradeService.buyFillImage(item.records.serialNo, compressImage)
        .then((value) {
      if (value.statusCode == 201) {
        final BuyItem item = BuyItem.fromJson(value.data);
        setState(() {
          this.item = item;
        });
      } else {
        alertDialog(context, content: value.data.toString());
      }
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }
}
