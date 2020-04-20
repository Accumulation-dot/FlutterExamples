import 'package:chain_app/models/task_record_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任务记录'),
      ),
      body: InfiniteListView<TaskRecord>(
//        initState: LoadingState(),
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据');
        },
        onRetrieveData: (p, items, refresh) {
          return WebServices.newsTaskList(p: p).then((value) {
            if (refresh) {
              items.clear();
            }
            print(value);
            final TaskRecordList taskList = TaskRecordList.fromJson(value.data);
            items.addAll(taskList.list);
            return int.parse(taskList.next) != 0;
          }).catchError((e) {
            print(e.toString());
          });
        },
        itemBuilder: (list, index, context) {
          TaskRecord item = list[index];
          return Card(
            child: ListTile(
              title: Text(item.date),
              trailing: Text("${item.earn}"),
            ),
          );
        },
      ),
    );
  }
}
