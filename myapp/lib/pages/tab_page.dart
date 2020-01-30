import 'package:flutter/material.dart';
import 'package:myapp/pages/category_list_page.dart';
import 'package:myapp/pages/home_page.dart';

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

  List<Widget> pages = [HomePage(), CategoryListPage(), HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: bottom[currentIndex].title,
        centerTitle: true,
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
