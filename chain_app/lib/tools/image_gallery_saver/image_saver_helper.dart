import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSaverHelper {
  /// 保存图片到本地
  static Future<String> saveImage(BuildContext context) async {
    RenderRepaintBoundary boundary = context.findRenderObject();
    ui.Image image = await boundary.toImage();

    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(byteData.buffer.asUint8List()));
    return result;
  }
}
