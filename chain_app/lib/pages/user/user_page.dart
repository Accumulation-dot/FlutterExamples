import 'package:chain_app/tools/routes.dart';
import 'package:flutter/material.dart';

enum ActionType {
  pay,
  record
}

class Action {
  final IconData iconData;
  final String title;
  final ActionType actionType;

  const Action({this.iconData, this.title, this.actionType});

}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}



class _UserPageState extends State<UserPage> {
  
  
  List<Action>actions = [
    Action(iconData: Icons.account_balance_wallet, title: '支付方式', actionType: ActionType.pay),
    Action(iconData: Icons.description, title: '交易记录', actionType: ActionType.record),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
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
                background: InkWell(
                  onTap: () {
                    print(111);
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            child: Icon(Icons.account_circle),
                            padding: const EdgeInsets.only(left: 30, top: 30),
                          ),
                        ),
                        Expanded(
                          child: Padding(padding: const EdgeInsets.only(left: 30, top: 0,),child: Text('用户名'),),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
                  Action action = actions[index];
              return ListTile(
                leading: Icon(action.iconData, color: Theme.of(context).accentColor,),
                title: Text('${action.title}'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  switch (action.actionType) {
                    case ActionType.pay:
                      Navigator.of(context).pushNamed(Routes.pay);
                      break;
                    case ActionType.record:
                      Navigator.of(context).pushNamed(Routes.records);
                      break;
                  }
                },
              );
            }, childCount: actions.length//50个列表项
                ),
          ),
        ],
      ),
    );
  }
}
