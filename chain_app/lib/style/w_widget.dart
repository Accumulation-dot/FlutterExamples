import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';

class WWidget {
  static TabBar tabBar(List<Tab> tabs, TabController controller) {
    return TabBar(
      tabs: tabs,
      isScrollable: tabs.length > 3,
      controller: controller,
    );
  }

  static Widget copyWidgets(String content,
      {Widget child =
          const Text('复制', style: WStyle.blue, textAlign: TextAlign.end)}) {
    return InkWell(
      child: child,
      onTap: () {
        ActionsWidget.copyContentWidget(content);
      },
    );
  }

  static Widget circularProgress({Color color = Colors.lightBlueAccent}) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
    );
  }

  static Widget circularPressed(
      {VoidCallback onPressed,
      String title = '',
      Color textColor = Colors.white,
      Color color = Colors.orange}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: textColor)),
      shape: WStyle.roundedBorder20,
      color: color,
    );
  }

  static Widget titleWidget(
      {String content = '',
      TextAlign textAlign = TextAlign.start,
      TextStyle textStyle = WStyle.titleStyle}) {
    return Text(
      content,
      style: textStyle,
      textAlign: textAlign,
    );
  }

  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Widget orangeRoundedButton(
      {VoidCallback onPressed,
      String content,
      Color backgroundColor = Colors.orange,
      TextStyle textStyle = const TextStyle(color: Colors.white)}) {
    return FlatButton(
        color: backgroundColor,
        shape: WStyle.roundedBorder20,
        onPressed: onPressed,
        child: Text(
          content,
          style: textStyle,
        ));
  }

  static Widget tipWidget(String content,
      {TextStyle textStyle = WStyle.tipStyle,
      TextAlign textAlign = TextAlign.end}) {
    return Text(
      content,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
