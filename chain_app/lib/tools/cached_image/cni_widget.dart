import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// cached_network_image 进行封装
class CNIWidget {
  static Widget cachedImageWidget(
      {String imageUrl,
      PlaceholderWidgetBuilder placeholder,
      LoadingErrorWidgetBuilder errorWidget,
      Size size}) {
    return CachedNetworkImage(
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
    );
  }
}

