import 'package:chain_app/pages/user/widgets/action.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealPage extends StatefulWidget {
  @override
  _DealPageState createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          UAction(
              iconData: Icons.file_upload,
              title: '挂单出售信息',
              actionType: ActionType.sell_mine,
              route: Routes.sell_mine),
          UAction(
            iconData: Icons.file_download,
            title: '挂单求购信息',
            actionType: ActionType.buy_mine,
            route: Routes.buy_mine,
          ),
          UAction(
            iconData: Icons.add_to_photos,
            title: '吃单出售信息',
            actionType: ActionType.sell_order,
            route: Routes.sell_order,
          ),
          UAction(
            iconData: Icons.lock_outline,
            title: '吃单求购信息',
            actionType: ActionType.buy_order,
            route: Routes.buy_order,
          )
        ].map((action) {
          return ListTile(
            leading: Icon(
              action.iconData,
              color: Theme.of(context).accentColor,
            ),
            title: Text('${action.title}'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).pushNamed(action.route);
            },
          );
        }).toList(),
      ),
    );
  }
}
