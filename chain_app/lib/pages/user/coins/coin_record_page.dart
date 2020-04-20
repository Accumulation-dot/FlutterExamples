import 'package:chain_app/models/coin_record_list.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class CoinRecordPage extends StatefulWidget {
  @override
  _CoinRecordPageState createState() => _CoinRecordPageState();
}

class _CoinRecordPageState extends State<CoinRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('币获取记录'),
        centerTitle: true,
      ),
      body: InfiniteListView(onRetrieveData: (p, items, refresh) {
        return WebServices.coinsRecord(p: p).then((value) {
          if (refresh) {
            items.clear();
          }
          CoinRecordList coinRecordList = CoinRecordList.fromJson(value.data);
          items.addAll(coinRecordList.list);
        }).catchError((e) {
          alertDialog(context, content: e.toString());
        });
      }, itemBuilder: (items, index, context) {
        CoinRecord coinRecord = items[index];
//        Icon icon;
        Color color;
        if (coinRecord.point > 0 || coinRecord.shop > 0) {
          color = Colors.green;
//          icon = Icon(
//            Icons.monetization_on,
//            color: color,
//            size: 50,
//          );
        } else {
          color = Colors.red;
//          icon = Icon(
//            Icons.monetization_on,
//            color: color,
//            size: 50,
//          );
        }
        return ListTile(
          isThreeLine: true,
          leading: SizedBox(
            width: 50,
            child: Center(
              child: Icon(
                Icons.monetization_on,
                color: color,
                size: 50,
              ),
            ),
          ),
          title: Text(
            coinRecord.desc,
            style: TextStyle(color: color),
          ),
          subtitle: Text(
            'ECO: ${coinRecord.point}\n购物币: ${coinRecord.shop}',
            style: TextStyle(color: color),
          ),
          trailing: SizedBox(
            width: 100,
            child: Center(
              child: Text(
                coinRecord.datetime,
                style: TextStyle(fontSize: 10, color: Colors.blueAccent),
              ),
            ),
          ),
        );
      }),
    );
  }
}
