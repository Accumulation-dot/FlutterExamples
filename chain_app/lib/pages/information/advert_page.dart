import 'package:chain_app/models/advert_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/services.dart';
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

class _AdvertPageState extends State<AdvertPage>
    with AutomaticKeepAliveClientMixin {
  ///
  final List<String> data = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: widget.needNav
          ? AppBar(
              title: Text('广告页'),
            )
          : null,
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
                  title: item.username,
                  subtitle: item.datetime,
                  userTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.advert_personal,
                      arguments: item.username,
                    );
                  }),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        heroTag: 'advertisement',
        onPressed: () async {
          print('object');
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          final token = sharedPreferences.getString(NServices.token);
          if (token != null && token.length > 0) {
            Navigator.of(context).pushNamed(Routes.add_advert);
          } else {
            Navigator.of(context).pushNamed(Routes.login);
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  addAdvert() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(NServices.token).length > 0) {
      Navigator.of(context).pushNamed(Routes.add_advert);
    } else {
      Navigator.of(context).pushNamed(Routes.login);
    }
  }
}
