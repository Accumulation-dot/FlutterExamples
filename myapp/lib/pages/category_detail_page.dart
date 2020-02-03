import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/commodity.dart';
import 'package:english_words/english_words.dart';
import 'package:myapp/pages/pages_global.dart';

/// Category 商品列表
class CategoryDetailPage extends StatefulWidget {
  final Category category;

  final bool showAppbar;

  CategoryDetailPage({Key key, this.category, this.showAppbar = false})
      : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> with AutomaticKeepAliveClientMixin {
  final List<Commodity> data = [];


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshHeader();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget content = RefreshIndicator(
      onRefresh: _refreshHeader,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          Commodity commodity = data[index];
          return ListTile(
            title: Text(commodity.title),
            leading: Icon(commodity.iconData),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PagesGlobal.commodity, arguments: commodity);
            },
          );
        },
      ),
    );
    return widget.showAppbar
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.category.title),
              centerTitle: true,
            ),
            body: content,
          )
        : Scaffold(
          body: content,
        );
  }

  Future _refreshHeader() async {
    await Future.delayed(Duration(seconds: 3)).then((e) {
      if (mounted) {
        setState(() {
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.title));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.games));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.access_alarm));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.backup));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.category));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.dashboard));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.event));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.fastfood));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.games));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.home));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.find_in_page));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.format_align_justify));
          data.add(Commodity(
              title: generateWordPairs().take(1).first.asCamelCase,
              iconData: Icons.keyboard));
        });
      }
    });
  }
}
