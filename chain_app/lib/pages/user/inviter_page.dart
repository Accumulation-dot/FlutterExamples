import 'dart:typed_data';

import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/image_gallery_saver/image_saver_helper.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/services/services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class InviterPage extends StatefulWidget {
  @override
  _InviterPageState createState() => _InviterPageState();
}

class _InviterPageState extends State<InviterPage> {
  GlobalKey _globalKey = GlobalKey();

  String web = AppConfig.registerHtml + '?' + 'inviter=' + Global.userInfo.code;

  String image = AppConfig.baseUrl + 'static/img/inviter_bg.jpeg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的邀请码'),
        centerTitle: true,
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.fill)),
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                QrImage(
                  data: web,
                  size: 160,
                  embeddedImage: Image.asset('images/icon.jpg').image,
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(30, 30)),
                ),
                Expanded(
                    flex: 1,
                    child: Text('${Global.userInfo.code}'))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _saveImage();
          },
          child: Text('保存')),
    );
  }

  _saveImage() async {
    final permissions = await Permission.storage.request();
    if (permissions == PermissionStatus.denied ||
        permissions == PermissionStatus.undetermined) {
      alertDialog(context, content: '你没有保存图片到相册的权限');
      return;
    }
    // ImageSaverHelper.saveImage(_globalKey.currentContext)
    saveImage().then((String value) {
      if (value.isNotEmpty) {
        SManager.showMessage('保存成功');
      } else {
        SManager.showMessage('保存失败');
      }
    }).catchError((error) {
      alertDialog(context, content: error.toString());
    });
  }

  Future<String> saveImage() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(byteData.buffer.asUint8List()));
    return result;
  }
}
