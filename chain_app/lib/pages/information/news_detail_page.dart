import 'dart:async';

import 'package:chain_app/models/news_list.dart';
import 'package:chain_app/tools/services/news_services.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final News item;
  const NewsDetailPage({Key key, this.item}) : super(key: key);
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  static final timeCount = 180;

  Timer timer;

  int seconds = 0;

  bool active = true;

  bool canAdd = false;

  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: WebView(
        initialUrl: widget.item.url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
      ),
      floatingActionButton: canAdd
          ? FloatingActionButton(
              onPressed: () {
                if (!active) {
                  NewsServices.newsTask(date).then((value) {
                    int code = value.statusCode;
                    var data = value.data;
                    if (code == 200) {
                      SManager.showMessage(value.data);
                      canAdd = false;
                    } else if (code == 201) {
                      canAdd = false;
                      SManager.showMessage('领取成功');
                    } else if (code == 205) {
                      date = formatDate(
                        DateTime.now(),
                        [yyyy, '-', mm, '-', dd],
                      );
                      canAdd = true;
                      seconds = 0;
                      timer.cancel();
                      timer = Timer.periodic(
                        const Duration(seconds: 1),
                        (t) async {
                          seconds += 1;
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setInt(date, seconds);
                          if (seconds >= timeCount) {
                            active = false;
                            t.cancel();
                          }
                        },
                      );
                    }
                    setState(() {});
                  }).catchError((error) {
                    SManager.dioErrorHandle(context, error);
                  });
                } else {
                  SManager.showMessage('请继续阅读，以达到时间要求');
                }
              },
              child: Text(active ? '${timeCount - seconds}s' : '领取\n奖励'),
            )
          : null,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  Future<void> read() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    seconds = sharedPreferences.getInt(date) ?? 0;
    if (seconds >= timeCount) {
      active = false;
    }

    NewsServices.taskCheck().then((value) {
      int code = value.statusCode;
      if (code == 202) {
        canAdd = false;
      } else {
        canAdd = true;
        if (timer != null) {
          timer.cancel();
        }
        if (timer == null) {
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (t) async {
              seconds += 1;
              sharedPreferences.setInt(date, seconds);
              if (seconds >= timeCount) {
                active = false;
                t.cancel();
              }
              setState(() {});
            },
          );
        }
      }
      setState(() {});
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }
}
