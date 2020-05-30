import 'package:chain_app/models/team_list.dart';
import 'package:chain_app/tools/global.dart';
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
      body:InfiniteListView<Member>(
          pageSize: 30,
          onRetrieveData: (pg, items, refresh) {
            return UserServices.team(p: pg).then((value) {
              TeamList team = TeamList.fromJson(value.data);
              if (refresh) {
                items.clear();
              }
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
                  child: Text('${Tools.hideMobile(member.username)}', style: TextStyle(fontSize: 24),),
                ),
                subtitle: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text('加入日期: ${member.date_joined}'),
                ),
              ),
            );
          }),
//      Column(
//        children: <Widget>[
//          Container(
//            height: 80,
//            color: Colors.orange,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Center(
//                  child: Text(
//                    '我的邀请码: ${Global.userInfo.code}',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Container(
//            color: Colors.orange,
//            height: 40,
//            padding: const EdgeInsets.only(left: 20),
//            child: Align(
//              child: Text(
//                '我的队员',
//                style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.white),
//              ),
//              alignment: Alignment.centerLeft,
//            ),
//          ),
//          Expanded(
//              child: Container(
//            child: ,
//          ))
//        ],
//      ),
    );
  }
}
