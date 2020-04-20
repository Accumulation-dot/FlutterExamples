import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/models/buy_order_list.dart';
import 'package:chain_app/pages/trade/mine/buy_order_detail_page.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
//import '';

class BuyOrderPage extends StatefulWidget {
  @override
  _BuyOrderPageState createState() => _BuyOrderPageState();
}

class _BuyOrderPageState extends State<BuyOrderPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
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
//      return Center(child: Text('${e}'),);
      return InfiniteListView<BuyOrder>(
          pageSize: size,
          onRetrieveData: (page, items, refresh) {
            return TradeService.buyOrdered(e, p: page, s: size)
                .then((value) {
              if (refresh) {
                items.clear();
              }
              BuyOrderList buyOrderList = BuyOrderList.fromJson(value.data);

              items.addAll(buyOrderList.list);
              return int.parse(buyOrderList.next) != 0;
            }).catchError((e) {});
          },
          itemBuilder: (items, index, context) {
            BuyOrder item = items[index];
            return Card(
              child: ListTile(
                title: WidgetGlobal.tradeSellWidget(
                  number: item.buy.number,
                  price: item.buy.price,
                ),
                subtitle: Text(item.created),
                trailing: RaisedButton(
                  color: Colors.orange,
                  child: Text(
                    '查看',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: WidgetStyle.roundedBorder(circular: 20),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return BuyOrderDetailPage(
                          order: item,
                        );
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
