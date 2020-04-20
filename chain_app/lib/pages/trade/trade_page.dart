import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/models/sell_list.dart';
import 'package:chain_app/models/sell_order_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/pages/trade/choice.dart';
import 'package:chain_app/pages/trade/mine/buy_order_detail_page.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/trade_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'mine/sell_order_detail_page.dart';

class TradePage extends StatefulWidget {
  @override
  _TradePageState createState() => _TradePageState();
}

const int pageSize = 10;

class _TradePageState extends State<TradePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;

//  List<Tab> tabs = Choice.tradeList().map((e) {
//    return Tab(
//      text: e.title,
//    );
//  }).toList();

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ECO交易区'),
        actions: <Widget>[
          PopupMenuButton<ChoiceType>(
            icon: Icon(Icons.add_circle_outline),
            onSelected: (result) {
              switch (result) {
                case ChoiceType.buy:
                  Navigator.of(context)
                      .pushNamed(Routes.add_trade, arguments: TradeType.buy);
                  break;
                case ChoiceType.sell:
                  Navigator.of(context)
                      .pushNamed(Routes.add_trade, arguments: TradeType.sell);
                  break;
                case ChoiceType.other:
//                  Navigator.of(context).pushNamed(Routes.records);
                  break;
                case ChoiceType.sell_my:
                  Navigator.of(context).pushNamed(Routes.sell_mine);
                  break;
                case ChoiceType.buy_my:
                  Navigator.of(context).pushNamed(Routes.buy_mine);
                  break;
                case ChoiceType.sell_order:
                  Navigator.of(context).pushNamed(Routes.sell_order);
                  break;
                case ChoiceType.buy_order:
                  Navigator.of(context).pushNamed(Routes.buy_order);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return Choice.tradeList(other: true).map((choice) {
                final color = Theme.of(context).accentColor;
                return PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(choice.iconData, color: color),
                      Text(choice.title, style: TextStyle(color: color)),
                    ],
                  ),
                  value: choice.choiceType,
                );
              }).toList();
            },
          ),
        ],
        bottom:
            Widgets.tabBar([Tab(text: '求购信息'), Tab(text: '出售信息')], _controller),
      ),
      body: TabBarView(
        children: [TradeBuyPage(), TradeSellPage()],
        controller: _controller,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TradeBuyPage extends StatefulWidget {
  final bool navigator;

  final String title;

  const TradeBuyPage({
    Key key,
    this.navigator = false,
    this.title,
  }) : super(key: key);

  @override
  _TradeBuyPageState createState() => _TradeBuyPageState();
}

class _TradeBuyPageState extends State<TradeBuyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.navigator
          ? AppBar(
              title: Text(
                widget.title,
              ),
            )
          : null,
      body: InfiniteListView<BuyItem>(
        pageSize: pageSize,
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(
            text: '总数: ${list.length}, 没有更多数据',
          );
        },
        onRetrieveData: (page, items, refresh) {
          return TradeService.tradeBuy(
            p: page,
            s: pageSize,
          ).then((value) {
            if (refresh) {
              items.clear();
            }
            final BuyList buyList = BuyList.fromJson(value.data);
            items.addAll(buyList.list);
            return int.parse(buyList.next) != 0;
          }).catchError((onError) {
            alertDialog(context, content: onError.toString());
          });
        },
        itemBuilder: (list, index, context) {
          BuyItem item = list[index];
          return Card(
            child: ListTile(
              isThreeLine: true,
              title: Text(
                '...${item.user.split('-').last}',
              ),
              subtitle: WidgetGlobal.tradeListWidget(
                number: item.number,
                price: item.price,
              ),
              trailing: FlatButton(
                onPressed: () {
                  alertDialog(
                    context,
                    content: '确定要预定此订单？',
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          TradeService.buyOrder(item.serialNo).then((value) {
                            if (value.statusCode == 201) {
                              BuyOrder order = BuyOrder.fromJson(value.data);
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) {
                                  return BuyOrderDetailPage(
                                    order: order,
                                  );
                                }),
                              );
                            } else {
                              alertDialog(context, content: value.data);
                            }
                          }).catchError((onError) {
                            alertDialog(context, content: onError.toString());
                          });
                        },
                        child: Text('确定'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('取消'),
                      )
                    ],
                  );
                },
                child: Text(
                  item.statusDesc,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.orange,
                shape: WidgetStyle.roundedBorder(
                  circular: 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/* 出售列表
* 所有的出售信息
* **/
class TradeSellPage extends StatefulWidget {
  final bool navigator;

  final String title;

  const TradeSellPage({
    Key key,
    this.navigator = false,
    this.title,
  }) : super(key: key);

  @override
  _TradeSellPageState createState() => _TradeSellPageState();
}

class _TradeSellPageState extends State<TradeSellPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.navigator
          ? AppBar(
              title: Text(widget.title),
            )
          : null,
      body: InfiniteListView<SellItem>(
        pageSize: pageSize,
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(
            text: '总数: ${list.length}, 没有更多数据',
          );
        },
        onRetrieveData: (page, items, refresh) {
          return TradeService.tradeSell(
            p: page,
            s: pageSize,
          ).then((value) {
            if (refresh) {
              items.clear();
            }
            final SellList sellList = SellList.fromJson(value.data);
            items.addAll(sellList.list);
            return int.parse(sellList.next) != 0;
          }).catchError((onError) {
            Fluttertoast.showToast(
              msg: onError.toString(),
            );
          });
        },
        itemBuilder: (list, index, context) {
          SellItem item = list[index];
          return Card(
            child: ListTile(
              isThreeLine: true,
              title: Text(
                '...${item.user.split('-').last}',
              ),
              subtitle: WidgetGlobal.tradeListWidget(
                number: item.number,
                price: item.price,
              ),
              trailing: FlatButton(
                child: Text(
                  item.statusDesc,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.orange,
                shape: WidgetStyle.roundedBorder(
                  circular: 20,
                ),
                onPressed: () {
                  TradeService.sellOrder(item.serialNo).then((value) {
                    if (value.statusCode == 201) {
                      SellOrder sellOrder = SellOrder.fromJson(value.data);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return SellOrderDetailPage(
                            sellOrder: sellOrder,
                          );
                        }),
                      );
                    } else {
                      alertDialog(context, content: value.data);
                    }
                  }).catchError((onError) {
                    alertDialog(context, content: onError.toString());
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
