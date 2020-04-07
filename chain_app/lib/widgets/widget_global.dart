import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}
