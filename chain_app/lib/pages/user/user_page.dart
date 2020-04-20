import 'dart:math';

import 'package:chain_app/models/summary.dart';
import 'package:chain_app/pages/user/widgets/action.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UAction> actions = [
    UAction(
      iconData: Icons.person_pin,
      title: '个人验证信息',
      actionType: ActionType.personal,
      route: Routes.personal_info,
    ),
    UAction(
      iconData: Icons.account_balance_wallet,
      title: '支付宝',
      actionType: ActionType.pay,
      route: Routes.pay,
      needArgument: true,
    ),
    UAction(
      iconData: Icons.credit_card,
      title: '银行卡',
      actionType: ActionType.bank,
      route: Routes.pay,
      needArgument: true,
    ),
//    UAction(
//      iconData: Icons.description,
//      title: '交易记录',
//      actionType: ActionType.record,
//      route: Routes.records,
//    ),
    UAction(
      iconData: Icons.receipt,
      title: '节点记录',
      actionType: ActionType.machine_record,
      route: Routes.machine_mine,
    ),
    UAction(
      iconData: Icons.add_to_photos,
      title: '我的任务',
      actionType: ActionType.daily_task,
      route: Routes.daily_task,
    ),
    UAction(
      iconData: Icons.dehaze,
      title: '交易',
      actionType: ActionType.deal,
      route: Routes.deal,
    ),
    UAction(
      iconData: Icons.share,
      title: '邀请好友',
      actionType: ActionType.inviter,
      route: Routes.inviter,
    ),
    UAction(
      iconData: Icons.settings,
      title: '设置',
      actionType: ActionType.setting,
      route: Routes.setting,
    ),
  ];

  Summary summary;

  bool isRequest = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              print('pressed');
              if (this.isRequest) {
                Fluttertoast.showToast(msg: '当前网络正在请求中，请稍后');
                return;
              }
              _request();
            },
          )
        ],
      ),
      body: CustomScrollView(
        reverse: false,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Center(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          top: 10,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '用户名: ${summary != null ? summary.name : ''}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          top: 10,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Text(
                                summary != null
                                    ? '可用币: ${summary.count}, 购物币: ${summary.shop}'
                                    : '可用币: 0.0, 购物币: 0.0',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                  '查看',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.coins_record);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                      left: 30,
                      top: 10,
                    )))
                  ],
                ),
              ),
            ),
          ),
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建列表项
                UAction action = actions[index];
                return ListTile(
                  leading: Icon(
                    action.iconData,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text('${action.title}'),
                  trailing: trailing(action),
                  onTap: () {
                    if (action.needArgument) {
                      Navigator.of(context).pushNamed(action.route,
                          arguments: action.actionType);
                    } else {
                      Navigator.of(context).pushNamed(action.route);
                    }
                  },
                );
              },
              childCount: actions.length, //50个列表项
            ),
          ),
        ],
      ),
    );
  }

  _request() async {
    setState(() {
      this.isRequest = true;
    });
    WebServices.personSummary().then((value) {
      print(value);
      this.summary = Summary.fromJson(value.data);
      this.isRequest = false;
      setState(() {});
    }).catchError((e) {
      this.isRequest = false;
    });
  }

  Widget trailing(UAction action) {
    if (this.summary == null) {
      return Icon(Icons.keyboard_arrow_right);
    }
    switch (action.actionType) {
      case ActionType.pay:
        {
          if (this.summary != null && this.summary.ali != 0) {
            return SizedBox(
              width: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('已绑定'),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            );
          }
          break;
        }
      case ActionType.bank:
        {
          if (this.summary.bank != 0) {
            return SizedBox(
              width: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('已绑定'),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            );
          }
          break;
        }
      case ActionType.personal:
        {
          if (this.summary.identified != 0) {
            return SizedBox(
              width: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('已验证'),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            );
          }
          break;
        }
      default:
        break;
    }
    return Icon(Icons.keyboard_arrow_right);
  }
}
