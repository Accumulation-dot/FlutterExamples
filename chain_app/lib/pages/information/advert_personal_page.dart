import 'package:chain_app/models/advert_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class AdvertPersonalPage extends StatefulWidget {
  /// 用户名
  final String username;

  const AdvertPersonalPage({Key key, this.username}) : super(key: key);

  @override
  _AdvertPersonalPageState createState() => _AdvertPersonalPageState();
}

class _AdvertPersonalPageState extends State<AdvertPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username ?? '个人广告'),
      ),
      body: InfiniteListView<AdvertItem>(
        onRetrieveData: (page, items, refresh) async {
          return WebServices.advertList(
            p: page,
          ).then((value) {
            print(value);
            if (refresh) {
              items.clear();
            }
            final advertList = AdvertList.fromJson(value.data);
            items.addAll(advertList.list);
            return advertList.next.length != 0;
          }).catchError((e) {
            print(e);
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
                title: '',
                subtitle: item.datetime,
              ),
              onTap: () {},
            ),
          );
        },
        loadingBuilder: (_) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: "总数: ${list.length}");
        },
      ),
    );
  }
}
