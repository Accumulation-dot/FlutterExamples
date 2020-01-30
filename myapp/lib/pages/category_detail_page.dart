import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';

/// Category 商品列表
class CategoryDetailPage extends StatefulWidget {
  final Category category;

  CategoryDetailPage({Key key, this.category}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.category.title),
      ),
    );
  }
}
