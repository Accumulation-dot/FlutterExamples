import 'package:chain_app/models/advert_list.dart';
import 'package:chain_app/pages/information/advert_info.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/flukit/fk_widget.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/news_services.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class AdvertMine extends StatefulWidget {
  @override
  _AdvertMineState createState() => _AdvertMineState();
}

class _AdvertMineState extends State<AdvertMine> {

  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我发布的广告'),
        centerTitle: true,
      ),
      body: isShow ? InfiniteListView<AdvertItem>(
        onRetrieveData: (p, items, r) {
          return NewsServices.advertMine().then((value) {
            AdvertList advertList = AdvertList.fromJson(value.data);
            if (r) {
              items.clear();
            }
            items.addAll(advertList.list);
            return int.parse(advertList.next) != 0;
          }).catchError((error) {
            SManager.dioErrorHandle(context, error);
          });
        },
        itemBuilder: (items, index, context) {
          AdvertItem item = items[index];
          return Card(
            child: ListTile(
              leading: InfoWidget.cachedImageWidget(
                imageUrl: item.img,
              ),
              title: Container(
                alignment: Alignment.centerLeft,
                child: Text('${item.title}'),
                padding: WStyle.symmetric(v: 10),
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: Text('${item.datetime}'),
                padding: WStyle.symmetric(v: 10),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AdvertInfo(item: item, mine: true);
                })).then((value) {
                  isShow = true;
                  setState(() {

                  });
                });
                isShow = false;
                setState(() {

                });
              },
            ),
          );
        },
        emptyBuilder: (refresh, context) {
          return FluKitWidget.empty(refresh, context);
        },
      ) : Container(),
    );
  }
}
