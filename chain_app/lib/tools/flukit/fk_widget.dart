import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

/// flukit 部分组件封装
class FluKitWidget {
  static const EdgeInsets edgeInsets8 = const EdgeInsets.all(8);

  /// 没有更多数据Widget
  static Widget noMoreWidget(
      {String text = '没有更多数据',
      TextStyle style = const TextStyle(color: Colors.grey)}) {
    return Center(
      child: Padding(
        padding: edgeInsets8,
        child: Text(text, style: style),
      ),
    );
  }

  /// 加载中Widget
  static Widget loadingWidget() {
    return Padding(
      padding: edgeInsets8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedRotationBox(
              duration: Duration(milliseconds: 800),
              child: GradientCircularProgressIndicator(
                  radius: 10.0,
                  colors: [Colors.blue, Colors.lightBlue[50]],
                  value: .8,
                  backgroundColor: Colors.transparent,
                  strokeCapRound: true)),
          Text("  加载更多..."),
        ],
      ),
    );
  }

  static Widget empty(VoidCallback callback, BuildContext context) {
    return InkWell(
      child: Center(
        child: Text('没有数据'),
      ),
      onTap: callback,
    );
  }
}
