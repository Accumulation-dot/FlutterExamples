import 'package:chain_app/models/sell_list.dart';
import 'package:chain_app/pages/trade/mine/sell_detail_page.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/trade_services.dart';
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
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('我的出售信息'),
          bottom: Widgets.tabBar([
            Tab(text: '出售中'),
            Tab(text: '待付款'),
            Tab(text: '待放币'),
            Tab(text: '已完成'),
          ], _controller)),
      body: TabBarView(
        children: tabTabChildren(),
        controller: _controller,
      ),
    );
  }

  tabTabChildren() {
    int size = 10;
    return [0, 1, 2, 3].asMap().keys.map((e) {
      return InfiniteListView<SellItem>(
          onRetrieveData: (page, items, refresh) {
            return TradeService.sellMine(stus: e, p: page, s: size)
                .then((value) {
              if (refresh) {
                items.clear();
              }
              SellList sellList = SellList.fromJson(value.data);
              items.addAll(sellList.list);
              return int.parse(sellList.next) != 0;
            }).catchError((error) {
              SManager.dioErrorHandle(context, error);
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
                trailing: e == 3
                    ? Text(
                        '完成',
                        style: TextStyle(color: Colors.green),
                      )
                    : RaisedButton(
                        color: Colors.orange,
                        child: Text(
                          '查看',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: WStyle.roundedBorder20,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return SellDetailPage(sellItem: item);
                          }));
                        },
                      ),
              ),
            );
          });
    }).toList();
  }
}
