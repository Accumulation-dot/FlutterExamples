import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class CommoditiesPage extends StatefulWidget {
  @override
  _CommoditiesPageState createState() => _CommoditiesPageState();
}

class _CommoditiesPageState extends State<CommoditiesPage>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  /// 数据结果集
  final _list = <WordPair>[];

  ///
  ScrollController _scrollController = ScrollController();

  /// 是否处于加载状态中
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _requestMore();
    //   }
    // });
    _requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
        centerTitle: true,
      ),
      body: _list.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _requestRefresh,
              child: ListView.separated(
                itemCount: _list.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return _widgetForPair(_list[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                physics: AlwaysScrollableScrollPhysics(),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _widgetForPair(WordPair pair) {
    return ListTile(
      title: Text(pair.asPascalCase),
      onTap: () {
        print("show custom");
      },
    );
  }

  Future _requestRefresh() async {
    _requestDataWithMore(false);
  }

  Future _requestMore() async {
    _requestDataWithMore(true);
  }

  Future _requestDataWithMore(bool more) async {
    if (isLoading) return;
    isLoading = true;
    await Future.delayed(Duration(seconds: 3)).then((e) {
      if (mounted) {
        setState(() {
          if (!more) {
            _list.clear();
          }
          _list.addAll(generateWordPairs().take(10));
          isLoading = false;
        });
      }
    });
  }
}
