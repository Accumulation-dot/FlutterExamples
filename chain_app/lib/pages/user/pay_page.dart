import 'package:chain_app/models/pay_list.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
//  bool _init = false;
//
//  var scrollView = GlobalKey<PullRefreshBoxState>();
//
  final list = <Pay>[];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('支付方式'),
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.add),
//              onPressed: () async {
//                final result =
//                    await Navigator.of(context).pushNamed(Routes.pay_detail);
//                if (result != null) {
//                  setState(() {
//                    _init = false;
//                  });
//                }
//              })
//        ],
//      ),
//      body: AfterLayout(
//        callback: (context) {
//          if (!_init) {
//            _init = true;
//            scrollView.currentState.show();
//          }
//        },
//        child: PullRefreshBox(
//          key: scrollView,
//          onRefresh: () async {
//            WebServices.pays(p: 1).then((value) {
//              print(value);
//              PayList payList = PayList.fromJson(value.data);
//              list.clear();
//              list.addAll(payList.list);
//              setState(() {});
//            }).catchError((e) {
//              print(e);
//            });
//          },
//          child: ListView.builder(
//            physics: ClampingScrollPhysics(),
//            itemCount: list.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text('${index}'),
//              );
//            },
//          ),
//        ),
//      ),
//    );
//  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final result =
                    await Navigator.of(context).pushNamed(Routes.pay_detail);
                if (result != null) {
                  list.insert(0, result);
                  setState(() {});
                }
              })
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PullRefreshBox(
            onRefresh: () => _onRefresh(),
            indicator: DefaultPullRefreshIndicator(),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                Pay pay = list[index];
                return Dismissible(
                  key: Key('${pay.id}'),
                  child: ListTile(
                    title: Text('${pay.name}'),
                    subtitle: Text('${pay.number}'),
                  ),
                  onDismissed: (r) async {
                    list.removeAt(index);
                    await WebServices.delPay(pay.id).then((value) {
                      Fluttertoast.showToast(msg: '删除成功');
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: "$e");
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _onRefresh({int page = 1}) async {
    WebServices.pays(p: page).then((value) {
      print(value);
      PayList payList = PayList.fromJson(value.data);
      list.clear();
      list.addAll(payList.list);
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }
}

/**
    Scaffold(
    appBar: AppBar(
    title: Text('收款方式'),
    actions: <Widget>[
    IconButton(icon: Icon(Icons.add), onPressed: () async {
    final result = await Navigator.of(context).pushNamed(Routes.pay_detail);
    if (result != null) {
    }
    })
    ],
    ),
    body: InfiniteListView<Pay>(
    key: scrollView,
    onRetrieveData: (page, s, r) {
    if (r) {
    s.clear();
    }
    return WebServices.pays(p: page).then((value) {
    PayList payList = PayList.fromJson(value.data);
    s.addAll(payList.list ?? []);
    if (int.parse(payList.next) == 0) {
    return false;
    }
    return true;
    }).catchError((e) {
    print(e);
    });
    },
    itemBuilder: (s, i, c) {
    Pay item = s[i];
    return Dismissible(
    key: Key('key_${s[i]}'),
    onDismissed: (_) {
    s.removeAt(i);
    },
    child: Card(
    child: ListTile(
    title: Text(item.name),
    subtitle: Text(item.number),
    trailing: IconButton(icon: Icon(Icons.delete_forever), onPressed: () {
    },),
    onTap: () async {
    final result = await Navigator.of(context).pushNamed(Routes.pay_detail, arguments: item);
    if (result != null) {
    setState(() {
    s[i] = result;
    });
    }
    },
    ),
    ),
    );
    },
    loadingBuilder: (context) => InfoWidget.loadingWidget(),
    noMoreViewBuilder: (list, context) => InfoWidget.noMoreWidget(),
    ),
    );
 */
