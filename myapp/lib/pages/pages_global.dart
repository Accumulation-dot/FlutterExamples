import 'package:flutter/material.dart';
import 'package:myapp/pages/category_detail_page.dart';
import 'package:myapp/pages/category_list_page.dart';
import 'package:myapp/pages/commodities_page.dart';
import 'package:myapp/pages/tab_page.dart';
import 'package:myapp/pages/welcome_page.dart';

class PagesGlobal {
  static const String tab = '/tab';

  static const String home = '/home';

  static const String about = '/about';

  static const String category_list = '/category_list';

  static const String category_detail = '/category_detail';

  static const String commodities = '/commodities';

  static const String welcome = '/welcome';

  static routes() {
    return {
      PagesGlobal.tab: (BuildContext context) => TabBarPage(),
      PagesGlobal.commodities: (BuildContext context, {arguments}) =>
          CommoditiesPage(),
      PagesGlobal.category_list: (BuildContext context) =>
          CategoryListPage(),
      PagesGlobal.category_detail: (BuildContext context, {arguments}) =>
          CategoryDetailPage(
            category: arguments,
          ),
      PagesGlobal.welcome: (BuildContext context) => WelcomePage(),
    };
  }
}
