import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ChoiceType {
  /// 求购
  buy,

  /// 出售
  sell,

  /// other
  other,

  /// 我的求购
  buy_my,

  /// 我的出售
  sell_my,

  /// 求购预定
  buy_order,

  /// 出售预定
  sell_order,
}

enum TradeType {
  sell,
  buy,
}

class Choice {
  final String title;

  final IconData iconData;

  final ChoiceType choiceType;

  Choice(this.title, {this.iconData, this.choiceType = ChoiceType.buy});

  static List<Choice> tradeList({bool other = false}) {
    List<Choice> choices = [
      Choice(
        '添加求购信息',
        choiceType: ChoiceType.buy,
      ),
      Choice(
        '添加出售信息',
        choiceType: ChoiceType.sell,
      ),
    ];
    if (other) {
//      choices.add(Choice(
//        '我的交易信息',
//        Icons.receipt,
//        choiceType: ChoiceType.other,
//      ));
      choices.add(Choice(
        '我的求购信息',
        choiceType: ChoiceType.buy_my,
      ));
      choices.add(Choice(
        '我的出售信息',
        choiceType: ChoiceType.sell_my,
      ));

      choices.add(Choice(
        '我的出售预定',
        choiceType: ChoiceType.buy_order,
      ));

      choices.add(Choice(
        '我的求购预定',
        choiceType: ChoiceType.sell_order,
      ));
    }

    return choices;
  }
}
