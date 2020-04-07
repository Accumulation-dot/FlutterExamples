import 'package:chain_app/models/news_list.dart';
import 'package:chain_app/pages/information/widgets/info_widget.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: InfiniteListView<NewsItem>(
        initState: LoadingState(),
        loadingBuilder: (context) {
          return InfoWidget.loadingWidget();
        },
        noMoreViewBuilder: (list, context) {
          return InfoWidget.noMoreWidget(text: '总数: ${list.length}, 没有更多数据');
        },
        onRetrieveData: (page, items, refresh) {
          return WebServices.newsList(p: page).then((value) {
            if (refresh) {
              items.clear();
            }
            final news = NewsList.fromJson(value.data);
            items.addAll(news.list);
            return news.next.length != 0;
          }).catchError((e) {
            print(e);
          });
        },
        itemBuilder: (list, index, context) {
          NewsItem item = list[index];
          return InfoWidget.newsItemWidget(
            leading: InfoWidget.cachedImageWidget(
              imageUrl: item.url,
              size: Size(50, 50),
            ),
            title: Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: Text('${item.title}'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.login);
            },
            subtitle: InfoWidget.newsSubtitleWidget(
              datetime: item.datetime,
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
