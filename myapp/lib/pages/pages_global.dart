import 'package:flutter/material.dart';
import 'package:myapp/pages/categories_detail_page.dart';
import 'package:myapp/pages/categories_page.dart';
import 'package:myapp/pages/category_detail_page.dart';
import 'package:myapp/pages/commodities_page.dart';
import 'package:myapp/pages/commodity_detail_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/tab_bar_page.dart';
import 'package:myapp/pages/welcome_page.dart';
import 'package:myapp/provider/animated_icon_widget.dart';

///
class PagesGlobal {
  static const String tab = '/tab';

  static const String welcome = '/welcome';

  static const String about = '/about';

  static const String categories = '/categories';

  static const String category_detail = '/category_detail';

  static const String categories_detail = '/categories_detail';

  static const String commodities = '/commodities';

  static const String commodity = '/commodity';

  static const String login = '/login';

  static const String loader_test = '/loader_test';

  static const String animated_icon = 'animated_icon';

  static routes() {
    return {
      tab: (BuildContext context) => TabBarPage(),
      commodities: (BuildContext context, {arguments}) => CommoditiesPage(),
      categories: (BuildContext context) => CategoriesPage(),
      category_detail: (BuildContext context, {arguments}) =>
          CategoryDetailPage(
            category: arguments,
          ),
      welcome: (BuildContext context) => WelcomePage(),
      categories_detail: (BuildContext context, {arguments}) =>
          CategoriesDetailPage(
            categoriesSelection: arguments,
          ),
      commodity: (BuildContext context, {arguments}) => CommodityDetailPage(
            commodity: arguments,
          ),
      login: (BuildContext context) => LoginPage(),
      animated_icon: (BuildContext context) => AnimatedIconsWidget(),

      // PagesGlobal.loader_test: (BuildContext context,) {
      //   return Mult
      // }
    };
  }
}
