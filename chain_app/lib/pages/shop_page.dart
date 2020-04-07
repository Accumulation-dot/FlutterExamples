import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  /// 标题
  final String title;

  const ShopPage({Key key, this.title = ''}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<String> data = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title.isNotEmpty
          ? AppBar(
              centerTitle: true,
              title: Text(widget.title),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.machines);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () {
                    alert(context, message: '提示信息');
                  },
                )
              ],
            )
          : null,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return item(context, index);
          },
          separatorBuilder: (context, index) {
            return WidgetGlobal.divideWidget(context, index);
          },
          itemCount: data.length,
        ),
      ),
    );
  }

  Future _refresh() async {
    final duration = Duration(seconds: 3);
    await Future.delayed(duration).then((value) {
      if (mounted) {
        setState(() {
          data.clear();
          data.addAll(['2', '4', '6', '8', '10', '12', '14']);
        });
      }
    });
  }

  Widget item(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('大型矿机'),
                  padding: const EdgeInsets.only(bottom: 8.0),
                ),
                Text('租金 2 矿石'),
                Text('总产 2.4矿石'),
                Text('运行时长'),
                Text('限购数量'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    '库存 100000',
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  child: FlatButton(
                    onPressed: () {
                      print('press');
                    },
                    child: Text('租赁'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    color: Color.fromRGBO(255, 165, 79, 1),
                  ),
                  width: 80,
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
