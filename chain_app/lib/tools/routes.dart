import 'package:chain_app/pages/account_book_page.dart';
import 'package:chain_app/pages/information/advert_add_page.dart';
import 'package:chain_app/pages/information/advert_info.dart';
import 'package:chain_app/pages/information/advert_mine.dart';
import 'package:chain_app/pages/information/advert_personal_page.dart';
import 'package:chain_app/pages/information/news_page.dart';
import 'package:chain_app/pages/login/cs_page.dart';
import 'package:chain_app/pages/login/login_page.dart';
import 'package:chain_app/pages/machine/machine_mine_page.dart';
import 'package:chain_app/pages/shop_page.dart';
import 'package:chain_app/pages/tab_page.dart';
import 'package:chain_app/pages/trade/mine/buy_order_page.dart';
import 'package:chain_app/pages/trade/mine/buy_page.dart';
import 'package:chain_app/pages/trade/mine/sell_order_page.dart';
import 'package:chain_app/pages/trade/mine/sell_page.dart';
import 'package:chain_app/pages/trade/mine/trade_add_page.dart';
import 'package:chain_app/pages/user/coins/coin_record_page.dart';
import 'package:chain_app/pages/user/coins/team_page.dart';
import 'package:chain_app/pages/user/daily_task_page.dart';
import 'package:chain_app/pages/user/deal_page.dart';
import 'package:chain_app/pages/user/inviter_page.dart';
import 'package:chain_app/pages/user/pay_detail_page.dart';
import 'package:chain_app/pages/user/pay_page.dart';
import 'package:chain_app/pages/user/personal_page.dart';
import 'package:chain_app/pages/user/setting_page.dart';
import 'package:chain_app/pages/user/task_page.dart';
import 'package:chain_app/pages/welcome/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const tab = '/tab';

  static const notice = '/notice';

  static const notice_list = '/notice_list';

  static const home = '/home';

  static const shop = '/shop';

  static const data = 'data';

  static const machines = '/machines';

  static const account_book = '/account_book';

  static const record = '/record';

  static const news = '/news';

  static const login = '/login';

  static const register = '/register';

  static const welcome = '/';

  static const add_advert = '/add_advert';

  static const advert_personal = '/advert_personal';

  static const records = '/records';

  static const pay = '/pay';

  static const pay_detail = '/pay_detial';

  static const machine_mine = '/machine_mine';

  static const task_record = '/task_record';

  static const daily_task = '/daily_task';

  static const personal_info = '/personal_info';

  static const setting = '/setting';

  static const coins_record = '/coins_record';

  static const sell_mine = '/sell_mine';

  static const buy_mine = '/buy_mine';

  static const sell_order = '/sell_order';

  static const buy_order = '/buy_order';

  static const add_trade = '/add_trade';

  static const deal = '/deal';

  static const inviter = '/inviter';

  static const cs = '/cs';

  static const team = '/team';

  static const advert_mine = '/advert_mine';

  static const advert_info = '/advert_info';

  static Map<String, WidgetBuilder> routes() {
    return {
      Routes.welcome: (context) => WelcomePage(),
      Routes.tab: (context) => TabPage(),
      Routes.buy_order: (context) => BuyOrderPage(),
      Routes.sell_order: (context) => SellOrderPage(),
      Routes.machine_mine: (BuildContext context) => MachineMinePage(),
      Routes.daily_task: (BuildContext context) => DailyTaskPage(),
      Routes.task_record: (BuildContext context) => TaskPage(),
      Routes.personal_info: (BuildContext context) => PersonalPage(),
      Routes.setting: (BuildContext context) => SettingPage(),
      Routes.coins_record: (BuildContext context) => CoinRecordPage(),
      Routes.sell_mine: (BuildContext context) => SellPage(),
      Routes.buy_mine: (BuildContext context) => BuyPage(),
      Routes.news: (context) => NewsPage(),
      Routes.shop: (context) => ShopPage(),
      Routes.deal: (context) => DealPage(),
      Routes.login: (context) => LoginPage(),
      Routes.inviter: (context) => InviterPage(),
      Routes.cs: (context) => CSPage(),
      Routes.team: (context) => TeamPage(),
      Routes.add_advert: (context) => AdvertAddPage(),
      Routes.advert_mine: (context) => AdvertMine(),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings routes) {
    final name = routes.name;
    final allRoutes = <String, WidgetBuilder>{
      Routes.account_book: (context) =>
          AccountBookPage(userID: routes.arguments),
      Routes.advert_personal: (BuildContext context) =>
          AdvertPersonalPage(username: routes.arguments),
      Routes.pay: (BuildContext context) =>
          PayPage(actionType: routes.arguments),
      Routes.pay_detail: (BuildContext context) =>
          PayDetailPage(actionType: routes.arguments),
      Routes.add_trade: (context) => TradeAddPage(tradeType: routes.arguments),
      Routes.advert_info: (context) => AdvertInfo(item: routes.arguments,),
    };

    final Function routerBuilder = allRoutes[name];

    return routerBuilder != null
        ? MaterialPageRoute(
            builder: (BuildContext context) => routerBuilder(context))
        : null;
  }
}
