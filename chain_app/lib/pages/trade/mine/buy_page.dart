import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/pages/trade/mine/buy_detail_page.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

//  TabBar(
//  controller: _controller,
//  isScrollable: true,
//  tabs: <Tab>[
//  Tab(text: '出售中'),
//  Tab(text: '待付款'),
//  Tab(text: '已付款'),
//  Tab(text: '已完成'),
//  Tab(text: '已取消'),
//  ],
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: Widgets.tabBar([
          Tab(text: '求购中'),
          Tab(text: '待付款'),
          Tab(text: '已付款'),
          Tab(text: '已完成'),
        ], _controller),
        centerTitle: true,
        title: Text('我的求购信息'),
      ),
      body: TabBarView(
        children: tabTabChildren(),
        controller: _controller,
      ),
    );
  }

  tabTabChildren() {
    int size = 10;
    return [0, 1, 2, 3].asMap().keys.map((e) {
      return InfiniteListView<BuyItem>(
          pageSize: size,
          onRetrieveData: (page, items, refresh) {
            return TradeService.buyMine(stus: e, p: page, s: size)
                .then((value) {
              print(value);
              if (refresh) {
                items.clear();
              }
              BuyList buyList = BuyList.fromJson(value.data);
              items.addAll(buyList.list);
              return int.parse(buyList.next) != 0;
            }).catchError((error) {
              SManager.dioErrorHandle(context, error);
            });
          },
          itemBuilder: (items, index, context) {
            BuyItem item = items[index];
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
                            return BuyDetailPage(
                              buyItem: item,
                            );
                          }));
                        },
                      ),
              ),
            );
          });
    }).toList();
  }
}
