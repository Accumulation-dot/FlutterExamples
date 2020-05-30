import 'package:chain_app/models/sell_order_list.dart';
import 'package:chain_app/pages/trade/mine/sell_order_detail_page.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class SellOrderPage extends StatefulWidget {
  @override
  _SellOrderPageState createState() => _SellOrderPageState();
}

class _SellOrderPageState extends State<SellOrderPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的预定'),
        centerTitle: true,
        bottom: TabBar(controller: _controller, tabs: [
          Tab(
            text: '待付款',
          ),
          Tab(
            text: '已付款',
          ),
          Tab(
            text: '已完成',
          ),
        ]),
      ),
      body: TabBarView(
        children: bodyChildren(),
        controller: _controller,
      ),
    );
  }

  bodyChildren() {
    int size = 10;
    return [0, 1, 2].asMap().keys.map((e) {
      return InfiniteListView<SellOrder>(
          pageSize: size,
          onRetrieveData: (page, items, refresh) {
            return TradeService.sellOrdered(e, p: page, s: size).then((value) {
              if (refresh) {
                items.clear();
              }
              SellOrderList sellOrderList = SellOrderList.fromJson(value.data);

              items.addAll(sellOrderList.list);
              return int.parse(sellOrderList.next) != 0;
            }).catchError((error) {
              SManager.dioErrorHandle(context, error);
            });
          },
          itemBuilder: (items, index, context) {
            SellOrder item = items[index];
            return Card(
              child: ListTile(
                title: WidgetGlobal.tradeSellWidget(
                  number: item.sell.number,
                  price: item.sell.price,
                ),
                subtitle: Text(item.created),
                trailing: e == 2
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return SellOrderDetailPage(sellOrder: item);
                            }),
                          );
                        },
                      ),
              ),
            );
          });
    }).toList();
  }
}
