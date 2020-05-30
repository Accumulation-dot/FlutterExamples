import 'package:chain_app/models/advert_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/app_config.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvertPage extends StatefulWidget {
  final bool needNav;

  const AdvertPage({Key key, this.needNav = false}) : super(key: key);

  @override
  _AdvertPageState createState() => _AdvertPageState();
}

class _AdvertPageState extends State<AdvertPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.needNav
          ? AppBar(
              title: Text('广告页'),
            )
          : null,
      body: InfiniteListView<AdvertItem>(
        onRetrieveData: (page, items, refresh) async {
          return WebServices.advertList(p: page).then((value) {
            print(value);
            if (refresh) {
              items.clear();
            }
            final advertList = AdvertList.fromJson(value.data);
            items.addAll(advertList.list);
            return int.parse(advertList.next) != 0;
          }).catchError((error) {
            SManager.dioErrorHandle(context, error);
          });
        },
        itemBuilder: (list, index, context) {
          AdvertItem item = list[index];
          return Card(
            child: ListTile(
              leading: InfoWidget.cachedImageWidget(
                imageUrl: item.img,
              ),
              title: Text('${item.title}'),
              subtitle: InfoWidget.advertItemSubtitleWidget(
                  title: Tools.hideMobile(item.user),
                  subtitle: item.datetime.split(' ').first),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.advert_info, arguments: item);
              },
            ),
          );
        },
        loadingBuilder: (_) {
          return InfoWidget.loadingWidget();
        },
        emptyBuilder: (callback, context) {
          return InkWell(
            child: Center(child: Text('没有数据'),),
            onTap: callback,
          );
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: "总数: ${list.length}");
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        heroTag: 'advertisement',
        onPressed: () {
          final token = Global
              .userInfo.token; //sharedPreferences.getString(STools.token);
          if (token != null && token.length > 0) {
            Navigator.of(context).pushNamed(Routes.add_advert);
          } else {
            Navigator.of(context).pushNamed(Routes.login);
          }
        },
      ),
    );
  }
}
