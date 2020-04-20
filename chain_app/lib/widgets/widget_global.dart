import 'package:cached_network_image/cached_network_image.dart';
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
    return circularProgressWidget();
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

  /// circularProgressWidget
  static Widget circularProgressWidget({Color color}) {
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
            text: '  价格  ',
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
            text: '  价格  ',
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
        ],
      ),
    );
  }
}

class Widgets {
  static TabBar tabBar(List<Tab> tabs, TabController controller) {
    return TabBar(tabs: tabs, isScrollable: tabs.length > 3, controller: controller,);
  }
}


class WidgetStyle {
  static roundedBorder({
    double circular = 0,
    BorderSide side = BorderSide.none,
  }) {
    return RoundedRectangleBorder(
      side: side,
      borderRadius: BorderRadius.circular(
        circular,
      ),
    );
  }

  static copyContent(String text) {
    ClipboardData data = ClipboardData(text: text);
    Clipboard.setData(data);
    Fluttertoast.showToast(msg: '复制成功', timeInSecForIos: 1);
  }

  static const greenStyle = const TextStyle(color: Colors.green);

  static const blueStyle = const TextStyle(color: Colors.blue);

  static Widget copyWidget(String content) {
    return InkWell(
      onTap: () {
        copyContent(content);
      },
      child: Text(
        '复制',
        textAlign: TextAlign.end,
        style: blueStyle,
      ),
    );
  }

  static TextSpan textSpan(
      {String pre = '',
      TextStyle preStyle = blueStyle,
      String content = '',
      TextStyle contentStyle = greenStyle}) {
    return TextSpan(
      text: pre,
      style: preStyle,
      children: [
        TextSpan(
          text: content,
          style: contentStyle,
        ),
      ],
    );
  }
}
