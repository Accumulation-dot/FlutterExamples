import 'dart:io';

import 'package:chain_app/models/rules.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/style/w_widget.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/coin_services.dart';
import 'package:chain_app/tools/services/news_services.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:chain_app/widgets/images_preview.dart';
import 'package:chain_app/widgets/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdvertTemp {
  String title;
  String content;
  File file;
}

class AdvertAddPage extends StatefulWidget {
  @override
  _AdvertAddPageState createState() => _AdvertAddPageState();
}

class _AdvertAddPageState extends State<AdvertAddPage> {

  AdvertTemp advert = AdvertTemp();

  TextEditingController _title = TextEditingController();

  TextEditingController _content = TextEditingController();

  Rule rule = Rule('', 0, 0.25, 0.15, 1.0);

  @override
  void initState() {
    super.initState();
    _request();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('添加广告'),
          centerTitle: true,
        ),
        body: InkWell(
            child: Container(
              padding: WStyle.symmetric(h: 20),
              child: ListView(
                children: <Widget>[
                  Container(
                      padding: WStyle.edgeInsetsOnly(
                        t: 20,
                      ),
                      child: WWidget.titleWidget(content: '标题')),
                  Container(
                      padding: WStyle.symmetric(v: 10),
                      child: TextField(
                        autofocus: true,
                        controller: _title,
                        decoration: InputDecoration(
                            hintText: '请输入标题', border: WStyle.inputBorder()),
                        maxLength: 20,
                        maxLines: 2,
                      )),
                  Container(child: WWidget.titleWidget(content: '请选择图片')),
                  advert.file == null
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Container(
                              child: FlatButton(
                                child: Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                                onPressed: _pickerImage,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          child: Image.file(
                            advert.file,
                            height: 80,
                          ),
                          onLongPress: () {
                            alertDialog(context,
                                content: '是否删除要选择的照片?',
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('取消')),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        advert.file = null;
                                        setState(() {});
                                      },
                                      child: Text('确定')),
                                ]);
                          },
                          onTap: () {
                            Navigator.of(context).push(
                              RouteAnimation(
                                ImagePreview(
                                  images: [advert.file],
                                  network: false,
                                ),
                              ),
                            );
                          },
                        ),
                  Container(child: WWidget.titleWidget(content: '内容')),
                  Container(
                      padding: WStyle.symmetric(v: 10),
                      child: TextField(
                        controller: _content,
                        maxLines: 8,
                        maxLength: 200,
                        decoration: InputDecoration(
                            hintText: '请输入广告内容', border: WStyle.inputBorder()),
                      )),
                  Center(
                    child: FlatButton(
                      color: Colors.orange,
                      child: Text(
                        '提交',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: WStyle.roundedBorder20,
                      onPressed: () {
                        var title = _title.text;
                        var content = _content.text;
                        if (title.isEmpty) {
                          alertDialog(context, content: '请输入标题');
                          return;
                        }
                        if (content.isEmpty) {
                          alertDialog(context, content: '请输入广告内容');
                          return;
                        }
                        if (advert.file == null) {
                          alertDialog(context, content: '请选择上传图片');
                          return;
                        }
                        NewsServices.advertAdd(title, advert.file, content).then((value) {
                          if (value.statusCode == 201) {
                            Navigator.of(context).pop(true);
                            SManager.showMessage('添加成功');
                          } else {
                            SManager.showMessage(value.data.toString());
                          }
                        }).catchError((error) {
                          print(error.toString());
                          SManager.dioErrorHandle(context, error);
                        });
                      },
                    ),
                  ),
                  Container(
                    child: WWidget.tipWidget('tips: 你需要花费${rule.advert}个SD'),
                  ),
                ],
              ),
            ),
            onTap: () {
              WWidget.hideKeyBoard(context);
            }));
  }

  _pickerImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var compressImage = await Tools.imageCompress(
        image, Tools.advertRandom(Global.userInfo.code));
    advert.file = compressImage;
    setState(() {});
  }

  _request() {
    CoinServices.ruleQuery().then((value) {
      Rules rules = Rules.fromJson(value.data);
      rule = rules.list.first;
      setState(() {
      });
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }
}
