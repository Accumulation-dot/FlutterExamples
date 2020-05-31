import 'package:chain_app/models/team_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/user_services.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的团队'),
        centerTitle: true,
      ),
      body: InfiniteListView<Member>(
        initState: LoadingState(),
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据');
        },
        onRetrieveData: (page, items, refresh) {
          return UserServices.team(p: page, s: 30).then((value) {
            if (refresh) {
              items.clear();
            }
            TeamList team = TeamList.fromJson(value.data);
            print(team.list.length);
            items.addAll(team.list);
            return int.parse(team.next) != 0;
          }).catchError((error) {
            SManager.dioErrorHandle(context, error);
          });
        },
        itemBuilder: (items, index, context) {
          Member member = items[index];
          return Card(
            child: ListTile(
              title: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '${Tools.hideMobile(member.username)}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              subtitle: Container(
                padding: const EdgeInsets.all(10),
                child: Text('加入日期: ${member.date_joined}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
