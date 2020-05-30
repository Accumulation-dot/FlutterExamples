import 'package:chain_app/models/summary.dart';
import 'package:chain_app/pages/user/widgets/action.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Summary summary;

  bool isRequest = false;

  @override
  void initState() {
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
            icon: Icon(Icons.headset_mic),
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.cs).then((value) {
              if (mounted) {
                _request();
              }
            }),
          )
        ],
      ),
      body: ListView(
        children: _widgetHeader() + _body(context),
      ),
    );
  }

  List<Widget> _widgetHeader() {
    return [
      Card(
        child: SizedBox(height: 100, child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                'images/icon.jpg',
                width: 40,
                height: 40,
              ),
            ),
            (summary != null && summary.name != null)
                ? Text('用户： \n${summary.name}', style: TextStyle(fontSize: 20),)
                : Text(''),
          ],
        ),),
      ),
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text('我的资产', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: FloatingActionButton(
                        heroTag: 'sub1',
                        onPressed: () {},
                        child: Text('SD'),
                      ),
                      width: 40,
                      height: 40,
                    ),
                    Container(
                      width: 20,
                    ),
                    (summary != null && summary.count != null)
                        ? Text('${summary.count}')
                        : Text('')
                  ],
                ),
              ),
              subtitle: Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(2),
                        child: FloatingActionButton(
                          heroTag: 'sub2',
                          child: Text('SP'),
                        ),
                        width: 40,
                        height: 40,
                      ),
                      Container(
                        width: 20,
                      ),
                      (summary != null && summary.shop != null)
                          ? Text('${summary.shop}')
                          : Text('')
                    ],
                  )),
              trailing: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.coins_record);
                },
                child: Text(
                  '明细',
                  style: TextStyle(color: Colors.white),
                ),
                shape: WStyle.roundedBorder20,
                color: Colors.orange,
              ),
            ),
          ],
        )
      ),
    ];
  }

  List<Widget> _body(BuildContext context) {
    List<UAction> actions = [
      UAction(
          iconData: Icons.person_pin,
          title: '个人验证信息',
          actionType: ActionType.personal,
          route: Routes.personal_info),
      UAction(
          iconData: Icons.account_balance_wallet,
          title: '支付宝',
          actionType: ActionType.pay,
          route: Routes.pay,
          needArgument: true),
      UAction(
          iconData: Icons.credit_card,
          title: '银行卡',
          actionType: ActionType.bank,
          route: Routes.pay,
          needArgument: true),
      UAction(
          iconData: Icons.receipt,
          title: '节点记录',
          actionType: ActionType.machine_record,
          route: Routes.machine_mine),
      UAction(
          iconData: Icons.add_to_photos,
          title: '我的任务',
          actionType: ActionType.daily_task,
          route: Routes.daily_task),
      UAction(
          iconData: Icons.dehaze,
          title: '交易',
          actionType: ActionType.deal,
          route: Routes.deal),
      UAction(
          iconData: Icons.add_comment,
          title: '我发布的广告',
          actionType: ActionType.advert,
          route: Routes.advert_mine),
      UAction(
          iconData: Icons.share,
          title: '邀请好友',
          actionType: ActionType.inviter,
          route: Routes.inviter),
      UAction(
          iconData: Icons.person_add,
          title: '我的团队',
          actionType: ActionType.team,
          route: Routes.team),
      UAction(
          iconData: Icons.settings,
          title: '设置',
          actionType: ActionType.setting,
          route: Routes.setting),
    ];
    return actions.map((action) {
      return ListTile(
        leading: Icon(
          action.iconData,
          color: Theme.of(context).accentColor,
        ),
        title: Text('${action.title}'),
        trailing: trailing(action),
        onTap: () {
          print(action.route);
          Navigator.of(context)
              .pushNamed(
            action.route,
            arguments: action.needArgument ? action.actionType : null,
          )
              .then((value) {
            if (mounted) {
              _request();
            }
          });
        },
      );
    }).toList();
  }

  _request() async {
    setState(() {
      this.isRequest = true;
    });
    WebServices.personSummary().then((value) {
      this.summary = Summary.fromJson(value.data);
      this.isRequest = false;
      setState(() {});
    }).catchError((error) {
      this.isRequest = false;
      SManager.dioErrorHandle(context, error);
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
