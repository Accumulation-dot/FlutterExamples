import 'dart:math';

import 'package:chain_app/models/machine_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MachinePage extends StatefulWidget {
  @override
  _MachinePageState createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headerSilverBuilder,
        body: InfiniteListView<Machine>(
          loadingBuilder: (context) {
            return InfoWidget.loadingWidget();
          },
          noMoreViewBuilder: (list, context) {
            return InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据');
          },
          onRetrieveData: (page, items, refresh) {
            return WebServices.machineList().then((value) {
              if (refresh) {
                items.clear();
              }
              if (value.statusCode == 200) {
                MachineList machineList = MachineList.fromJson(value.data);
                items.addAll(machineList.list);
              }
            }).catchError((e) {
              alertDialog(context, content: e.toString());
            });
          },
          itemBuilder: (items, index, context) {
            Machine machine = items[index];
            return Card(
              child: ListTile(
                leading: Icon(
                  Icons.monetization_on,
                  color: Colors.yellow,
                  size: 60,
                ),
                title: Text(machine.title),
                subtitle: Text(
                    '消费 ${machine.cost} 预计产出 ${machine.number}\n有效期预计 30 天'),
                isThreeLine: true,
                trailing: FlatButton(
                  color: Colors.orange,
                  child: Text(machine.given ? '体验' : '购买'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    if (machine.given) {
                      alertDialog(context, content: '体验项不能购买');
                      return;
                    }
                    WebServices.machineOrder(machine.sNo).then((value) {
                      print(value);
                      if (value.statusCode == 201) {
                        alertDialog(context, content: '购买成功');
                      } else {
                        alertDialog(context, content: value.data);
                      }
                    }).catchError((e) {
                      Fluttertoast.showToast(
                          msg: e.toString(), timeInSecForIos: 1);
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _headerSilverBuilder(BuildContext context, bool scrolled) {
    return <Widget>[
      SliverAppBar(
        centerTitle: true,
        floating: true,
        pinned: true,
        title: Text('节点包'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.machine_mine);
            },
            child: Text(
              '我的购买记录',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )
    ];
  }
}
