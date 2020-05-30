import 'package:chain_app/models/c_s.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/login_services.dart';
import 'package:chain_app/widgets/widget_global.dart';
import 'package:flutter/material.dart';

class CSPage extends StatefulWidget {
  @override
  _CSPageState createState() => _CSPageState();
}

class _CSPageState extends State<CSPage> {

  CS cs = CS('', '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('客服'),centerTitle: true,),
      body: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(20)),
          Text('${cs.content}', style: TextStyle(fontSize: 20),),
          Padding(padding: const EdgeInsets.all(20)),
          SizedBox(height: 50, child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('微信客服', style: TextStyle(color: Colors.blue, fontSize: 20),),
              Padding(padding: const EdgeInsets.all(20)),
              Text('${cs.wechat}', style: TextStyle(color: Colors.green),),
              Padding(padding: const EdgeInsets.all(20)),
              Widgets.copyWidgets(cs.wechat),
              Padding(padding: const EdgeInsets.all(10)),
            ],
          ),)
        ],
      ),
    );
  }

  _request() {
    LoginServices.cs().then((value) {
      cs = CS.fromJson(value.data);
      setState(() {

      });
    }).catchError((error){
      SManager.dioErrorHandle(context, error);
    });
  }
}
