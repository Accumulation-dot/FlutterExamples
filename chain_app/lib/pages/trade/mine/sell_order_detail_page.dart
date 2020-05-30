import 'package:chain_app/models/sell_order_list.dart';
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

  TextStyle blue = WStyle.blue;
  TextStyle green = WStyle.green;

  @override
  void initState() {
    super.initState();
    sellOrder = widget.sellOrder;
    controller = TextEditingController();
  }

  @override
  void dispose() {
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
              text: '  单价  ',
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
          trailing: Widgets.copyWidgets(pay.number),
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
      Divider(),
    ];

    return list;
  }

  status01() {
    String image = NServices.imageUrl(sellOrder.detail);
    List<Widget> list = [
      Divider(),
      TradeWidget.payWidget(image, onTap: () {
        Navigator.of(context)
            .push(RouteAnimation(ImagePreview(images: [image])));
      }),
      Divider()
    ];

    return list;
  }

  status02() {
    String image = NServices.imageUrl(sellOrder.detail);
    List<Widget> list = [
      Divider(),
      TradeWidget.payWidget(image, onTap: () {
        Navigator.of(context)
            .push(RouteAnimation(ImagePreview(images: [image])));
      }),
      Divider()
    ];

    return list;
  }

  _pickerImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    var compressImage = await Tools.imageCompress(image, sellOrder.serialNo);

    TradeService.sellFillImage(sellOrder.serialNo, compressImage).then((value) {
      if (value.statusCode == 201) {
        Navigator.of(context).pop();
        sellOrder = SellOrder.fromJson(value.data);
        setState(() {});
      } else {
        alertDialog(context, content: value.data.toString());
      }
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }
}
