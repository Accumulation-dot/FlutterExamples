import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';


class InfoWidget {
  // test url
  static const url =
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583572034702&di=830b6bd7924e9adb2f8030c1c284aeb0&imgtype=0&src=http%3A%2F%2Fimg3.tbcdn.cn%2Ftfscom%2Fi2%2F101742512%2FTB2x7C0nFXXXXbsXpXXXXXXXXXX_%2521%2521101742512.jpg';

  /// 图片缓存
  /// imageUrl: 图片链接
  /// placeholder: 构建水印图片
  /// errorWidget: 图片加载错误
  static Widget cachedImageWidget({
    String imageUrl,
    PlaceholderWidgetBuilder placeholder,
    LoadingErrorWidgetBuilder errorWidget,
    Size size = const Size(50, 50),
  }) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: placeholder ??
            (context, index) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
        errorWidget: errorWidget ??
            (context, url, obj) {
              return Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
      ),
    );
  }

  /// 标题类型
  static Widget titleWidget(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  /// 加载中Widget
  static Widget loadingWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              strokeCapRound: true,
            ),
          ),
          Text("  加载更多..."),
        ],
      ),
    );
  }

  /// 没有更多数据Widget
  static Widget noMoreWidget(
      {String text = '没有更多数据',
      TextStyle style = const TextStyle(color: Colors.grey)}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  static newsItemWidget(
      {Widget leading,
      Widget title,
      Widget subtitle,
      Widget trailing,
      VoidCallback onTap}) {
    return SizedBox(
      height: 90,
      child: Card(
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }

  static newsSubtitleWidget(
      {String title, String datetime, VoidCallback subTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
//        Expanded(
//          flex: 1,
//          child:
//        FlatButton(
//          onPressed: subTap,
//          child: Text(title),
//          color: Colors.amberAccent,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(20),
//          ),
//        ),

//        ),
//        Expanded(
//          flex: 2,
//          child:
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            datetime,
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
//        )
      ],
    );
  }

  /*
  *
  * */
  static advertItemWidget({String imageUrl, Widget title, Widget subtitle}) {
    return Card(
      child: ListTile(
        leading: cachedImageWidget(imageUrl: imageUrl),
        title: title,
        subtitle: subtitle,
      ),
    );
  }

  static advertItemSubtitleWidget(
      {String title, String subtitle, GestureTapCallback userTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: userTap,
          ),
        ),
        InkWell(
          child: Container(
//            decoration: BoxDecoration(
//              color: Colors.amberAccent,
//              border: Border.all(
//                color: Colors.amberAccent,
//                width: 1.0,
//                style: BorderStyle.solid,
//              ),
//              borderRadius: BorderRadius.all(Radius.circular(20)),
//            ),
            padding: const EdgeInsets.all(5),
            child: Text(subtitle),
          ),
          onTap: () {
            print('object');
          },
        ),
      ],
    );
  }
}
