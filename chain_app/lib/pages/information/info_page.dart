import 'package:chain_app/pages/information/advert_page.dart';
import 'package:chain_app/pages/information/news_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;

  final length = 3;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: length);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: [
            Tab(
              text: '头条',
            ),
            Tab(
              text: '广告',
            ),
            Tab(
              text: '商城',
            )
          ],
          controller: _controller,
        ),
      ),
      body: TabBarView(
        children: [
          NewsPage(),
          AdvertPage(),
          Center(
            child: Text(
              '等待开放',
              textAlign: TextAlign.center,
            ),
          )
        ],
        controller: _controller,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
