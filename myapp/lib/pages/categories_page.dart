import 'package:flutter/material.dart';
import 'package:myapp/models/categories_selection.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/pages/pages_global.dart';
import 'package:myapp/widget/widget_global.dart';

///
class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

///
class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  ///
  final List<Category> data = List<Category>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: _requestData,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final category = data[index];
              final text = Text(
                category.title,
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              );
              return WidgetGlobal.categoryWidgetWith(text, tapCallback: () {
                Navigator.of(context).pushNamed(
                    PagesGlobal.categories_detail,
                    arguments: CategoriesSelection(
                        categories: data, selectedIndex: index));
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  Widget categoryGridView(BuildContext context, Category category) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            PagesGlobal.category_detail,
            arguments: category,
          );
        },
        child: Container(
          color: Colors.green,
          child: Center(
            child: Text(
              category.title,
            ),
          ),
        ),
      ),
    );
  }

  Future _requestData() async {
    await Future.delayed(Duration(seconds: 3)).then((e) {
      if (mounted) {
        setState(() {
          data.clear();
          [
            Category(1, "机器人"),
            Category(2, "手办"),
            Category(3, "微颗粒"),
            Category(4, "益智玩具"),
            Category(5, "少儿玩具"),
            Category(1, "机器人"),
            Category(2, "手办"),
            Category(3, "微颗粒"),
            Category(4, "益智玩具"),
            Category(5, "少儿玩具"),
            Category(1, "机器人"),
            Category(2, "手办"),
            Category(3, "微颗粒"),
            Category(4, "益智玩具"),
            Category(5, "少儿玩具")
          ].forEach((e) {
            data.add(e);
          });
        });
      }
    });
  }
}
