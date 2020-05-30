import 'package:cached_network_image/cached_network_image.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/style/w_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MachineRow extends StatelessWidget {
  final String url;
  final String title;
  final TextSpan subTitle;
  final bool isFree;

  final VoidCallback onPressed;

  const MachineRow(
      {Key key,
      this.url,
      this.title = '',
      this.subTitle = const TextSpan(),
      this.isFree,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: WStyle.borderRadius4,
                child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                        child: url == null
                            ? Icon(
                                Icons.monetization_on,
                                color: Colors.yellow,
                                size: 60,
                              )
                            : CachedNetworkImage(
                                imageUrl: url,
                                placeholder: (context, url) =>
                                    WWidget.circularProgress(),
                              ))),
              ),
              Expanded(
                  child: Padding(
                padding: WStyle.symmetric(h: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: WStyle.symmetric(v: 10)),
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(padding: WStyle.edgeInsetsOnly(t: 10)),
                    Text.rich(subTitle),
                    Text.rich(WStyle.textSpans([
                      TextSpan(text: '有效期预计'),
                      TextSpan(
                          text: '30',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      TextSpan(text: '天'),
                    ])),
                    Padding(padding: WStyle.symmetric(v: 10))
                  ],
                ),
              )),
              Padding(
                padding: WStyle.edgeInsetsOnly(r: 10),
                child: WWidget.circularPressed(
                    onPressed: onPressed,
                    title: isFree ? '体验' : '购买',
                    textColor: isFree ? Colors.grey : Colors.white),
              ),
            ],
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
