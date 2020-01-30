import 'package:flutter/material.dart';
import 'package:myapp/pages/pages_global.dart';
import 'package:myapp/pages/tab_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      // routes: PagesGlobal.routes(),
      onGenerateRoute: (RouteSettings settings) {
        final name = settings.name;
        final Function routerBuilder = PagesGlobal.routes()[name];
        if (routerBuilder != null) {
          if (settings.arguments != null) {
            return MaterialPageRoute(
                builder: (context) =>
                    routerBuilder(context, arguments: settings.arguments));
          }
          return MaterialPageRoute(
              builder: (context) => routerBuilder(context));
        }
        return null;
      },
      home: new Scaffold(
        body: TabBarPage(),
      ),
      initialRoute: PagesGlobal.welcome,
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> items = List<String>();

  ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readData();
    _scrollController.addListener(() {
      print('listen');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('need more');
        readMore();
      }
    });
  }

  Future readData() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        items.clear();
        items.addAll(List<String>.generate(20, (i) => "Item ${i + 1}"));
        isLoading = false;
      });
    });
  }

  Future readMore() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        int length = items.length;
        items.addAll(List<String>.generate(20, (i) => "Item ${length + i}"));
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: readData,
      child: ListView.builder(
        itemCount: items.length * 2,
        controller: this._scrollController,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          final indexTemp = index ~/ 2;
          final item = items[indexTemp];

          return ListTile(
            title: Text('$item'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}

class SecondScreen extends StatelessWidget {
  final String title;

  SecondScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context, 'result');
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
