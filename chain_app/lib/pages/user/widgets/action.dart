import 'package:flutter/cupertino.dart';

enum ActionType {
  pay,
  bank,
  record,
  machine_record,
  daily_task,
  personal,
  setting,
  sell_mine,
  buy_mine,
  sell_order,
  buy_order,
  deal,
  inviter,
  team,
  advert,
}

class UAction {
  final IconData iconData;

  final String title;

  final ActionType actionType;

  final String route;

  final bool needArgument;

  const UAction(
      {this.iconData,
      this.title,
      this.actionType,
      this.route,
      this.needArgument = false});
}
