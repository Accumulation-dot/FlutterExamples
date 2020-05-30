import 'package:chain_app/pages/user/widgets/action.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flutter/material.dart';

class DropItem {
  final String text;
  final String value;

  const DropItem({this.text, this.value});
}

class PayDetailPage extends StatefulWidget {
  final ActionType actionType;

  PayDetailPage({Key key, this.actionType}) : super(key: key);

  @override
  _PayDetailPageState createState() => _PayDetailPageState();
}

class _PayDetailPageState extends State<PayDetailPage> {
  TextEditingController _number;

  DropItem item;

  String cardNo;

  List<DropItem> drops = [
    DropItem(text: '支付宝', value: 'ALI'),
    DropItem(text: '银行卡', value: 'BANK')
  ];

  Map<String, String> parameter = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    item = widget.pay != null ? DropItem(text: widget.pay.name, value: widget.pay.type) : drops.first;
//    _number = widget.pay != null ? TextEditingController(text: widget.pay.number);
    switch (widget.actionType) {
      case ActionType.pay:
        item = drops[0];
        break;
      case ActionType.bank:
        item = drops[1];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加新的支付方式'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: TextField(
                controller: _number,
                decoration: InputDecoration(
                    hintText: widget.actionType == ActionType.bank
                        ? '请输入银行卡号'
                        : '请输入支付宝手机号码'),
                keyboardType: TextInputType.number,
                maxLength: widget.actionType == ActionType.bank ? 19 : 11,
                enableInteractiveSelection: false,
                onChanged: (e) {
                  cardNo = e;
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('提交'),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  WebServices.addPay(
                          type: item.value,
                          name: item.text,
                          number: cardNo,
                          bank: widget.actionType == ActionType.bank)
                      .then((value) {
                    if (value.statusCode == 201) {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(Routes.tab));
                    } else {
                      alertDialog(context, title: '提示', content: value.data.toString());
                    }
                  }).catchError((error) {
                    SManager.dioErrorHandle(context, error);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
