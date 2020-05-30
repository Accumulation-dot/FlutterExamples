import 'package:chain_app/models/m_record_list.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/machine_services.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class MachineMinePage extends StatefulWidget {
  @override
  _MachineMinePageState createState() => _MachineMinePageState();
}

class _MachineMinePageState extends State<MachineMinePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final List<Tab> tabs = [
    Tab(
      text: '全部',
    ),
    Tab(
      text: '可用',
    ),
    Tab(
      text: '已过期',
    )
  ];

  @override
  void initState() {
    _controller =
        TabController(vsync: this, length: tabs.length, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: [Tab(text: '全部'), Tab(text: '可用'), Tab(text: '已过期')],
          controller: _controller,
        ),
      ),
      body: TabBarView(
        children: tabs.asMap().keys.map((index) {
          return InfiniteListView<MRecord>(
              onRetrieveData: (page, items, refresh) {
            return MachineServices.myMachine(s: index).then((value) {
              print(value);
              if (refresh) {
                items.clear();
              }
              if (value.statusCode == 200) {
                MRecordList mRecordList = MRecordList.fromJson(value.data);
                items.addAll(mRecordList.list);
              }
            }).catchError((error) {
              SManager.dioErrorHandle(context, error);
            });
          }, itemBuilder: (items, index, context) {
            MRecord mRecord = items[index];
            return Card(
              child: ListTile(
                title: Text('${mRecord.machine}'),
                subtitle:
                    Text('创建时间：${mRecord.created}\n过期时间：${mRecord.expired}'),
                trailing: FlatButton(
                  child: Text('每天产出 ${mRecord.number} 个'),
                ),
                isThreeLine: true,
              ),
            );
          });
        }).toList(),
        controller: _controller,
      ),
    );
  }

  /*
  * NestedScrollView(
        headerSliverBuilder: _headerSilverBuilder,
        body: InfiniteListView<Machine>(
            onRetrieveData: (page, items, refresh) {
              return WebServices.machineUsed()
                  .then((value) {})
                  .catchError((e) {});
            },
            itemBuilder: null),
      )*/

  List<Widget> _headerSilverBuilder(BuildContext context, bool scrolled) {
    return <Widget>[
      SliverAppBar(
        centerTitle: true,
        floating: true,
        pinned: false,
        title: Text('我的阅读包'),
      )
    ];
  }
}
