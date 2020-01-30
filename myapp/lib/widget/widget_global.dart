import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 创建所有的Widget
///
class WidgetGlobal {
  /// 创建Category的Widget
  static Widget categoryWidgetWith(Text text,
      {GestureTapCallback tapCallback, Color backgroundColor = Colors.white}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: tapCallback,
        child: Container(
          color: backgroundColor,
          child: Center(
            child: text,
          ),
        ),
      ),
    );
  }

  ///
  static Widget errorWidget(BuildContext context, String url, Object object) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Icon(Icons.error),
      ),
    );
  }

  ///
  static Widget placeholderWidget(BuildContext context, String url) {
    return WidgetGlobal.circularProgress();
  }

  ///
  static Widget bannerWidget(String url,
      {String title = '',
      PlaceholderWidgetBuilder placeholder = WidgetGlobal.placeholderWidget,
      LoadingErrorWidgetBuilder error = WidgetGlobal.errorWidget}) {
    return Stack(alignment: const Alignment(0.0, 0.8), children: <Widget>[
      Container(
        color: Colors.grey,
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: placeholder,
          errorWidget: error,
        ),
      ),
      Container(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        ),
      ),
    ]);
  }

  ///
  static Widget circularProgress() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
      ),
    );
  }
}
