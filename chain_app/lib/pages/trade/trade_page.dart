import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/pages/trade/choice.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:chain_app/models/trade_list.dart';

class TradePage extends StatefulWidget {
  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;

  List<Tab> tabs = Choice.tradeList().map((e) {
    return Tab(
      text: e.title,
      icon: Icon(e.iconData),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ECO交易区'),
        actions: <Widget>[
          PopupMenuButton<ChoiceType>(
            icon: Icon(Icons.add_circle_outline),
            onSelected: (result) {
              switch (result) {
                case ChoiceType.buy:
                  WebServices.addInRecord().then((value) {
                    alertDialog(context, content: '添加成功');
                  }).catchError((e) {
                    alertDialog(context, content: "$e");
                  });
                  break;
                case ChoiceType.sell:
                  break;
                case ChoiceType.other:
                  Navigator.of(context).pushNamed(Routes.records);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return Choice.tradeList(other: true).map((e) {
                final color = Theme.of(context).accentColor;
                return PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(e.iconData, color: color),
                      Text(
                        e.title,
                        style: TextStyle(color: color),
                      ),
                    ],
                  ),
                  value: e.choiceType,
                );
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          tabs: tabs,
          controller: _controller,
        ),
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

class _TradeBuyPageState extends State<TradeBuyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: widget.navigator
          ? AppBar(
        title: Text(
          widget.title,
        ),
      )
          : null,
      body: InfiniteListView<TradeItem>(
        initState: LoadingState(),
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据');
        },
        onRetrieveData: (page, items, refresh) {
          return WebServices.tradeInRecord(p: page).then((value) {
            if (refresh) {
              items.clear();
            }
            print(value);
            final news = TradeList.fromJson(value.data);
            items.addAll(news.list);
            return news.next.length != 0;
          }).catchError((e) {
            print(e);
          });
        },
        itemBuilder: (list, index, context) {
          TradeItem item = list[index];
          return Card(
            child: ListTile(
              title: Text(
                  '${index}'
              ),
//              subtitle: Text(item.statusDesc),
//              trailing: Text("${item.number}"),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/* 出售列表
* 所有的出售信息
* **/
class TradeSellPage extends StatefulWidget {
  final bool navigator;

  final String title;

  const TradeSellPage({Key key, this.navigator = false, this.title})
      : super(key: key);

  @override
  _TradeSellPageState createState() => _TradeSellPageState();
}

class _TradeSellPageState extends State<TradeSellPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: widget.navigator
          ? AppBar(
        title: Text(widget.title),
      )
          : null,
      body: InfiniteListView<TradeItem>(
//        initState: LoadingState(),
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据');
        },
        onRetrieveData: (page, items, refresh) {
          return WebServices.tradeOutRecord(p: page).then((value) {
            if (refresh) {
              items.clear();
            }
            print(value);
            final news = TradeList.fromJson(value.data);
            items.addAll(news.list);
            return news.next.length != 0;
          }).catchError((e) {
            print(e);
          });
        },
        itemBuilder: (list, index, context) {
          TradeItem item = list[index];
          return Card(
            child: ListTile(
              title: item.typeDesc != null ? Text(item.typeDesc) : null ,
              subtitle: Text(item.statusDesc),
              trailing: Text("${item.number}"),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}