
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


final GestureTapCallback callback = (){};

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

  static popupSelectItem(IconData iconData, String title, String identifier) {
    return PopupMenuItem<String>(
      value: identifier,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(
          title,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  static addressWidget({String title = '', String address = '', bool fav = false, int count = 0, GestureTapCallback tapCallback}) {
    GestureTapCallback callback = tapCallback;
    if (tapCallback == null) {
      callback = (){};
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),
                Text(
                  address,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          InkWell(
            child: Icon(Icons.star, color: fav ? Colors.red : Colors.grey,),
            onTap: callback,
          ),
          Text('$count'),
        ],
      ),
    );
  }
}
