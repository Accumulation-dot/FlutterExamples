import 'package:flutter/material.dart';

class AccountBookPage extends StatefulWidget {
  final String userID;

  const AccountBookPage({Key key, this.userID}) : super(key: key);

  @override
  _AccountBookPageState createState() => _AccountBookPageState();
}

class _AccountBookPageState extends State<AccountBookPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> tabs = [
    Tab(
      text: '团队算力',
    ),
    Tab(
      text: '帮扶券',
    ),
    Tab(
      text: '贡献值',
    ),
    Tab(text: '矿石')
  ];

  List<Widget> contents = [
    Center(
      child: Text(
        '团队算力',
      ),
    ),
    Center(
      child: Text(
        '帮扶券',
      ),
    ),
    Center(
      child: Text(
        '贡献值',
      ),
    ),
    Center(
      child: Text(
        '矿石',
      ),
    )
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
    return Scaffold(
      appBar: AppBar(
        title: Text('账本信息'),
        bottom: TabBar(
          tabs: tabs,
          controller: _controller,
        ),
      ),
      body: TabBarView(
        children: contents,
        controller: _controller,
      ),
    );
  }
}
