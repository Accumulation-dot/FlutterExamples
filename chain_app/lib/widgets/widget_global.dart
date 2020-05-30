import 'package:cached_network_image/cached_network_image.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetGlobal {
  static Widget divideWidget(BuildContext context, int index, {Color color}) {
    return Divider(
      color: color,
    );
  }

  /// placeholderWidget
  static Widget placeholderWidget(BuildContext context, String url) {
    return circularProgress();
  }

  /// errorWidget
  static Widget errorWidget(BuildContext context, String url, Object error) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
    );
  }
  
  static Widget emptyWidgets(VoidCallback refresh, BuildContext context) {
    return InkWell(
      onTap: refresh,
      child: Center(
        child: Text('没有更多数据'),
      ),
    );
  }

  /// circularProgressWidget
  static Widget circularProgress({Color color}) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          color ?? Colors.lightBlueAccent,
        ),
      ),
    );
  }

  ///
  static Widget homeBannerWidget(String imageUrl,
      {PlaceholderWidgetBuilder placeholderWidgetBuilder,
      LoadingErrorWidgetBuilder loadingErrorWidgetBuilder}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: placeholderWidgetBuilder ?? WidgetGlobal.placeholderWidget,
      errorWidget: loadingErrorWidgetBuilder ?? WidgetGlobal.errorWidget,
    );
  }

  static Widget noticeSummaryWidget(String title, String datetime,
      {GestureTapCallback onTap}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(datetime),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  static Widget tradeListWidget({double number, double price}) {
    return RichText(
      text: TextSpan(
        text: '数量  ',
        style: TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: number.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          TextSpan(
            text: '  单价  ',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: price.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          TextSpan(
            text: '\n总价  ',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: (number * price).toStringAsFixed(2),
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  static Widget tradeSellWidget({double number, double price}) {
    return RichText(
      text: TextSpan(
        text: '数量  ',
        style: TextStyle(
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: number.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          TextSpan(
            text: '  单价  ',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: price.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          WStyle.blueText('\n总价 '),
          WStyle.greenText((number * price).toStringAsFixed(2))
        ],
      ),
    );
  }
}

class Widgets {
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
}

class ActionsWidget {
  /// 拷贝内容
  static copyContentWidget(String text) {
    ClipboardData data = ClipboardData(text: text);
    Clipboard.setData(data);
    SManager.showMessage('复制成功');
  }
}
