import 'package:chain_app/models/sell_list.dart';
import 'package:chain_app/pages/trade/mine/sell_order_detail_page.dart';
import 'package:chain_app/pages/trade/mine/sell_detail_page.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的出售信息'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Tab>[
            Tab(text: '待预定'),
            Tab(text: '待付款'),
            Tab(text: '已付款'),
            Tab(text: '已完成'),
            Tab(text: '已取消'),
          ],
        ),
      ),
      body: TabBarView(
        children: tabTabChildren(),
        controller: _controller,
      ),
    );
  }

  tabTabChildren() {
    int size = 10;
    return [0, 1, 2, 3, 4].asMap().keys.map((e) {
      return InfiniteListView<SellItem>(
          pageSize: size,
          onRetrieveData: (page, items, refresh) {
            return TradeService.sellMine(stus: e, p: page, s: size)
                .then((value) {
              print(value);
              if (refresh) {
                items.clear();
              }
              SellList sellList = SellList.fromJson(value.data);
              items.addAll(sellList.list);
              return int.parse(sellList.next) != 0;
            }).catchError((error) {
              Fluttertoast.showToast(msg: error.toString());
            });
          },
          itemBuilder: (items, index, context) {
            SellItem item = items[index];
            return Card(
              child: ListTile(
                title: WidgetGlobal.tradeSellWidget(
                  number: item.number,
                  price: item.price,
                ),
                subtitle: Text(item.created),
                trailing: e == 3 ? Text('完成') : RaisedButton(
                  color: Colors.orange,
                  child: Text(
                    '查看',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: WidgetStyle.roundedBorder(circular: 20),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SellDetailPage(sellItem: item,);
                    }));
                  },
                ),
              ),
            );
          });
    }).toList();
  }
}
