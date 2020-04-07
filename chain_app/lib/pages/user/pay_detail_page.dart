import 'package:chain_app/models/pay_list.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flutter/material.dart';

class DropItem {
  final String text;
  final String value;

  const DropItem({this.text, this.value});
}

class PayDetailPage extends StatefulWidget {
  Pay pay;

  PayDetailPage({Key key, this.pay}) : super(key: key);

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
    if (widget.pay != null) {
//      item = ;
      for (DropItem item in drops) {
        if (widget.pay.type == item.value) {
          this.item = item;
          break;
        }
      }
      cardNo = widget.pay.number;
    } else {
      cardNo = '';
    }
    if (item == null) {
      item = drops.first;
    }
    _number = TextEditingController(text: cardNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.pay == null ? Text('添加新支付') : Text('编辑支付'),
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
              child: DropdownButton(
                items: drops.map((e) {
                  return DropdownMenuItem(
                    child: Text(e.text),
                    value: e,
                  );
                }).toList(),
                onChanged: (e) {
                  parameter['type'] = e.value;
                  parameter['name'] = e.text;
                },
                value: item,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: TextField(
                controller: _number,
                decoration: InputDecoration(hintText: '请输入卡号或者支付宝账号'),
                keyboardType: TextInputType.number,
                enableInteractiveSelection: false,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (e) {
                  cardNo = e;
                },
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (widget.pay != null) {
                    WebServices.updatePay(
                            id: widget.pay.id,
                            number: cardNo,
                            type: item.value,
                            name: item.text)
                        .then((value) {
                      Pay pay = Pay.fromJson(value.data);
                      widget.pay = pay;
                      Navigator.of(context).pop(pay);
                    }).catchError((e) {
                      print(e);
                    });
                  } else {
                    WebServices.addPay(
                            type: item.value, name: item.text, number: cardNo)
                        .then((value) {
                      print(value.statusCode);
                      print(value.statusMessage);
                      print(value.data);
                      if (value.statusCode == 201) {
                        Navigator.of(context).pop(Pay.fromJson(value.data));
                      } else {
                        print(value.data);
                      }
                    }).catchError((e) {
                      print(e.toString());
                    });
                  }
                },
                child: Text('提交'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
