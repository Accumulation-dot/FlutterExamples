import 'package:chain_app/pages/trade/trade.dart';
import 'package:chain_app/providers/login_provider.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
          ChangeNotifierProvider<Trade>(
            create: (_) => Trade(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
//          showSemanticsDebugger: true,
          initialRoute: Routes.welcome,
          onGenerateRoute: (RouteSettings routeSettings) =>
              Routes.onGenerateRoute(routeSettings),
          routes: Routes.routes(),
        ));
  }
}
