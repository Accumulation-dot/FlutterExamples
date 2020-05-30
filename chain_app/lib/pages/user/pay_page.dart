import 'package:chain_app/models/pay_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/pages/user/widgets/action.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class PayPage extends StatefulWidget {
  final ActionType actionType;

  const PayPage({Key key, this.actionType}) : super(key: key);
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actionType == ActionType.bank ? '银行卡信息' : '支付宝信息'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              alertDialog(context,
                  title: '修改提示',
                  content: '如果需要进行删除更改,请联系管理员',
                  barrierDismissible: true);
            },
          ),
        ],
      ),
      body: InfiniteListView<Pay>(
        initState: LoadingState(),
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: '');
        },
        onRetrieveData: (page, items, refresh) {
          return WebServices.pays(
                  p: page, bank: widget.actionType == ActionType.bank)
              .then((value) {
            print(value);
            if (value.statusCode == 200) {
              PayList payList = PayList.fromJson(value.data);
              if (payList.list.length > 0) {
                items.clear();
                items.addAll(payList.list);
              } else {}
            }
          }).catchError((e) {
            print(e);
          });
        },
        itemBuilder: (list, index, context) {
          Pay item = list[index];
          return Card(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(item.typeDesc),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  item.number,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          );
        },
        emptyBuilder: (refresh, context) {
          return InkWell(
            child: Card(
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Routes.pay_detail, arguments: widget.actionType);
            },
          );
        },
      ),
    );
  }
}
