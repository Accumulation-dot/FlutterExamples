import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myapp/pages/pages_global.dart';
import 'package:myapp/widget/widget_global.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final List<IconData> data = [];

  final List banner = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723625662&di=bc7be59dd27706ea65ea33a94c209477&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F12%2F40%2F43%2F18958PICYpQ.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723734494&di=864f7b85f900f0b68e8bc08f1c078eed&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201511%2F02%2F20151102140204_WUSwE.jpeg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723821634&di=e04d14690229411a560ccc6cf0e10f6a&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F01%2F96%2F56N58PICVWw_1024.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723821634&di=e04d14690229411a560ccc6cf0e10f6a&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F01%2F96%2F56N58PICVWw_1024.jpg"
  ];

  @override
  void initState() {
    super.initState();

    print('init');
    _headerRefresh();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _headerRefresh,
        child: ListView(
          children: <Widget>[
            Container(
              height: width * 0.6,
              child: Swiper(
                outer: false,
                itemBuilder: (context, index) {
                  return WidgetGlobal.bannerWidget(banner[index]);
                },
                onTap: (index) {
                  print(index);
                },
                pagination: SwiperPagination(margin: const EdgeInsets.all(5.0)),
                itemCount: banner.length,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$index"),
                  leading: Icon(data[index]),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              physics: NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }

  Future _headerRefresh() async {
    await Future.delayed(Duration(seconds: 3)).then((e) {
      if (mounted) {
        setState(() {
          data.clear();
          banner.clear();
          data.addAll([
            Icons.ac_unit,
            Icons.airport_shuttle,
            Icons.all_inclusive,
            Icons.beach_access,
            Icons.cake,
            Icons.free_breakfast,
            Icons.ac_unit,
            Icons.airport_shuttle,
            Icons.all_inclusive,
            Icons.beach_access,
            Icons.cake,
            Icons.free_breakfast
          ]);
          banner.addAll([
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723625662&di=bc7be59dd27706ea65ea33a94c209477&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F12%2F40%2F43%2F18958PICYpQ.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723734494&di=864f7b85f900f0b68e8bc08f1c078eed&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201511%2F02%2F20151102140204_WUSwE.jpeg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723821634&di=e04d14690229411a560ccc6cf0e10f6a&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F01%2F96%2F56N58PICVWw_1024.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562723821634&di=e04d14690229411a560ccc6cf0e10f6a&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F01%2F96%2F56N58PICVWw_1024.jpg"
          ]);
        });
      }
    });
  }

  Widget gridViewItem(int index) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PagesGlobal.commodities);
      },
      child: new Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: new Icon(
          data[index],
          color: Colors.grey,
        ),
      ),
    );
  }
}
