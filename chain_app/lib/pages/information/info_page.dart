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

  final List<Tab> tabs = [
    Tab(
      text: '头条',
    ),
    Tab(
      text: '广告',
    ),
  ];

  final List<Widget> contents = [
    NewsPage(),
    AdvertPage(),
  ];

  @override
  void initState() {
    _controller = TabController(vsync: this, length: tabs.length);
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
          tabs: tabs,
          controller: _controller,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera_alt,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: TabBarView(
        children: contents,
        controller: _controller,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
