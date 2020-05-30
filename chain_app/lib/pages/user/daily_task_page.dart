import 'package:chain_app/models/task_record_list.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/news_services.dart';
import 'package:flutter/material.dart';

class DailyTaskPage extends StatefulWidget {
  @override
  _DailyTaskPageState createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {
  bool completed = false;

  TaskRecord record = TaskRecord('', '', 0);

  @override
  void initState() {
    super.initState();
    _request();
  }

  ///
  /// 获取当天任务状态 如果有记录 为已完成
  /// 如果没有记录 当天为未完成
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日任务'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '任务记录',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.task_record);
            },
          ),
        ],
      ),
      body: ListTile(
        title: RichText(
          text: TextSpan(
            text: '今日任务 可获取',
            style: TextStyle(color: Colors.black87),
            children: <TextSpan>[
              TextSpan(
                text: record.earn.toStringAsFixed(3),
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ), //Text('今日任务 可获取 ${record.earn.toStringAsFixed(3)}'),
        subtitle: Text(completed ? '状态: 已完成' : "状态：未完成"),
        trailing: FlatButton(
          child: completed
              ? Text('已完成')
              : Text(
                  '去完成',
                  style: TextStyle(color: Colors.white),
                ),
          color: completed ? Colors.grey : Colors.orange,
          shape: WStyle.roundedBorder20,
          onPressed: () {
            if (completed) {
              SManager.showMessage('当日任务已完成');
              return;
            }
            Navigator.of(context).popUntil(ModalRoute.withName(Routes.tab));
          },
        ),
      ),
    );
  }

  _request() async {
    return NewsServices.taskCheck().then((value) {
      this.record = TaskRecord.fromJson(value.data);
      if (value.statusCode == 200) {
        completed = false;
      } else if (value.statusCode == 202) {
        completed = true;
      }
      setState(() {});
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }
}
