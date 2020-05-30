import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alert(BuildContext context,
    {String title = '提示', String message = '', VoidCallback cancel}) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('确定'),
            onPressed: cancel ??
                () {
                  Navigator.of(context).pop();
                },
          )
        ],
      );
    },
  );
}

void cupertinoAlertDialog(BuildContext context,
    {String title = '提示', String content = '', List<Widget> actions}) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions ??
            [
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
      );
    },
  );
}

/*
* 展示about内容 一般不会用到
* */
void aboutAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AboutDialog(
        applicationName: 'packageInfo.appName',
        applicationVersion: 'packageInfo.version',
        applicationIcon: Icon(Icons.settings_applications),
        children: <Widget>[
          Text('文本'),
        ],
      );
    },
  );
}

void alertDialog(BuildContext context,
    {String title = '提示',
    String content = '你需要补充内容',
    List<Widget> actions,
    bool barrierDismissible = false}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(title),
        ),
        content: Text(content),
        actions: actions ??
            [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('确定'),
              )
            ],
      );
    },
  );
}
