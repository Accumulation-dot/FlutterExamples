import 'package:flutter/material.dart';
import 'package:myapp/pages/categories_page.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/pages_global.dart';

final List<BottomNavigationBarItem> bottom = [
  BottomNavigationBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home, color: Colors.red),
      title: Text('主页')),
  BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      activeIcon: Icon(
        Icons.settings,
        color: Colors.red,
      ),
      title: Text('分类')),
  BottomNavigationBarItem(
      icon: Icon(Icons.search),
      activeIcon: Icon(
        Icons.search,
        color: Colors.red,
      ),
      title: Text('搜索'))
];

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int currentIndex = 0;

  List<Widget> pages = [HomePage(), CategoriesPage(), HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: bottom[currentIndex].title,
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.home),
          onTap: () {
            Navigator.of(context).pushNamed(PagesGlobal.login);
          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.scanner),
                  title: Text('扫一扫'),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.scanner),
                  title: Text('扫一扫'),
                ),
              )
            ],
            onSelected: (int index) {
              print(index);
            },
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedItem,
        currentIndex: currentIndex,
        items: bottom,
      ),
    );
  }

  selectedItem(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
