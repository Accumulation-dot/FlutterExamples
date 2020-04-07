import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ChoiceType {
  /// 求购
  buy,

  /// 出售
  sell,

  /// other
  other
}

class Choice {
  final String title;

  final IconData iconData;

  final ChoiceType choiceType;

  Choice(this.title, this.iconData, {this.choiceType = ChoiceType.buy});

  static List<Choice> tradeList({bool other = false}) {
    List<Choice> choices = [
      Choice(
        '求购信息',
        Icons.file_download,
        choiceType: ChoiceType.buy,
      ),
      Choice(
        '出售信息',
        Icons.file_upload,
        choiceType: ChoiceType.sell,
      ),
    ];
    if (other) {
      choices.add(Choice(
        '我的交易信息',
        Icons.receipt,
        choiceType: ChoiceType.other,
      ));
    }

    return choices;
  }
}
