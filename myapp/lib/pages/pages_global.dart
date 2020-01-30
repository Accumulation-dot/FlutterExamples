import 'package:flutter/material.dart';
import 'package:myapp/pages/categories_detail_page.dart';
import 'package:myapp/pages/categories_page.dart';
import 'package:myapp/pages/category_detail_page.dart';
import 'package:myapp/pages/commodities_page.dart';
import 'package:myapp/pages/tab_bar_page.dart';
import 'package:myapp/pages/welcome_page.dart';

///
class PagesGlobal {
  static const String tab = '/tab';

  static const String home = '/home';

  static const String about = '/about';

  static const String categories = '/categories';

  static const String category_detail = '/category_detail';

  static const String categories_detail = '/categories_detail';

  static const String commodities = '/commodities';

  static const String welcome = '/welcome';

  static routes() {
    return {
      PagesGlobal.tab: (BuildContext context) => TabBarPage(),
      PagesGlobal.commodities: (BuildContext context, {arguments}) =>
          CommoditiesPage(),
      PagesGlobal.categories: (BuildContext context) => CategoriesPage(),
      PagesGlobal.category_detail: (BuildContext context, {arguments}) =>
          CategoryDetailPage(
            category: arguments,
          ),
      PagesGlobal.welcome: (BuildContext context) => WelcomePage(),
      PagesGlobal.categories_detail: (BuildContext context, {arguments}) =>
          CategoriesDetailPage(
            categoriesSelection: arguments,
          ),
    };
  }
}
