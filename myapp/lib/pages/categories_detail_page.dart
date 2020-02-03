import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/categories_selection.dart';
import 'package:myapp/pages/category_detail_page.dart';

class CategoriesDetailPage extends StatefulWidget {
  final CategoriesSelection categoriesSelection;

  CategoriesDetailPage({Key key, this.categoriesSelection}) : super(key: key);

  @override
  _CategoriesDetailPageState createState() => _CategoriesDetailPageState();
}

class _CategoriesDetailPageState extends State<CategoriesDetailPage>
    with SingleTickerProviderStateMixin {
  List<Category> tabs;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = widget.categoriesSelection.categories;
    _tabController = TabController(
        length: tabs.length,
        vsync: this,
        initialIndex: widget.categoriesSelection.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品信息'),
        centerTitle: true,
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e.title)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return CategoryDetailPage(
            category: e,
          );
        }).toList(),
      ),
    );
  }
}
