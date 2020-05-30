import 'package:chain_app/models/machine_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/pages/machine/widgets/machine_row.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/machine_services.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class MachinePage extends StatefulWidget {
  @override
  _MachinePageState createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SD节点'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.machine_mine);
            },
            child: Text(
              '我的购买记录',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: InfiniteListView<Machine>(
        loadingBuilder: (context) => InfoWidget.loadingWidget(),
        noMoreViewBuilder: (list, context) =>
            InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据'),
        onRetrieveData: (page, items, refresh) {
          return MachineServices.machineList().then((value) {
            print(value);
            if (refresh) {
              items.clear();
            }
            if (value.statusCode == 200) {
              MachineList machineList = MachineList.fromJson(value.data);
              items.addAll(machineList.list);
            }
          }).catchError((error) {
            SManager.dioErrorHandle(context, error);
          });
        },
        itemBuilder: (items, index, context) {
          Machine machine = items[index];
          return MachineRow(
            title: machine.title,
            subTitle: WStyle.textSpans([
              TextSpan(text: '消费: '),
              TextSpan(
                  text: '${machine.cost}', style: TextStyle(color: Colors.red)),
              TextSpan(text: ', 预计产出: '),
              TextSpan(
                  text: '${machine.number}',
                  style: TextStyle(color: Colors.green))
            ]),
            isFree: machine.given,
            onPressed: () {
              _pressMachine(context, machine);
            },
          );
        },
      ),
    );
  }

  _pressMachine(BuildContext context, Machine machine) {
    if (machine.given) {
      alertDialog(context, content: '体验项不能购买');
      return;
    }
    final progress = ProgressHUD.of(context);
    progress.show();
    MachineServices.machineOrder(machine.sNo).then((value) {
      progress.dismiss();
      print(value);
      if (value.statusCode == 201) {
        alertDialog(context, content: '购买成功');
      } else {
        alertDialog(context, content: value.data.toString());
      }
    }).catchError((error) {
      progress.dismiss();
      SManager.dioErrorHandle(context, error);
    });
  }
}
