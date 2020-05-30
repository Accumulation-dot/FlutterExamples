import 'package:chain_app/models/advert_list.dart';
import 'package:chain_app/models/rules.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/style/w_widget.dart';
import 'package:chain_app/tools/cached_image/cni_widget.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/coin_services.dart';
import 'package:chain_app/tools/services/news_services.dart';
import 'package:chain_app/widgets/images_preview.dart';
import 'package:chain_app/widgets/route_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdvertInfo extends StatefulWidget {
  final AdvertItem item;

  final bool mine;

  const AdvertInfo({Key key, this.item, this.mine = false}) : super(key: key);
  @override
  _AdvertInfoState createState() => _AdvertInfoState();
}

class _AdvertInfoState extends State<AdvertInfo> {
  Rule rule = Rule('', 0, 0.25, 0.15, 1.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mine) {
      _request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.item.title}'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: _children(),
        ),
      ),
    );
  }

  _children() {
    List<Widget> children = [_datetime(), _image(), _content()];
    if (widget.mine) {
      children.addAll(_mine());
    }
    return children;
  }

  _title() {
    return Container(
      padding: WStyle.symmetric(v: 20),
      child: WWidget.titleWidget(
          content: widget.item.title, textAlign: TextAlign.center),
    );
  }

  _datetime() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        '${widget.item.datetime}',
        textAlign: TextAlign.right,
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
      ),
      padding: WStyle.symmetric(h: 20, v: 10),
    );
  }

  _image() {
    return InkWell(
      child: Container(
        height: 200,
        padding: WStyle.symmetric(v: 10, h: 20),
        child: CNIWidget.cachedImageWidget(
          imageUrl: widget.item.img,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          RouteAnimation(
            ImagePreview(
              images: [widget.item.img],
            ),
          ),
        );
      },
    );
  }

  _content() {
    return Container(
      padding: WStyle.symmetric(h: 20, v: 20),
      child: Text(
        widget.item.content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  _mine() {
    return [
      Container(
        padding: WStyle.symmetric(h: 20, v: 10),
        child: Center(
            child: WWidget.orangeRoundedButton(
                content: '置顶',
                onPressed: () {
                  NewsServices.advertUp(widget.item.id).then((value) {
                    if (value.statusCode == 202) {
                      Navigator.of(context).pop();
                      SManager.showMessage(value.data.toString());
                    } else {
                      SManager.showMessage(value.data.toString());
                    }
                  }).catchError((error) {
                    SManager.dioErrorHandle(context, error);
                  });
                })),
      ),
      Container(
        padding: WStyle.symmetric(h: 20),
        child: WWidget.tipWidget('tips: 你需要花费${rule.advert}个SD'),
      )
    ];
  }

  _request() {
    CoinServices.ruleQuery().then((value) {
      Rules rules = Rules.fromJson(value.data);
      rule = rules.list.first;
      setState(() {});
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }
}
