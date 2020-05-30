import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/routes.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/webservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  TextEditingController _name;

  TextEditingController _identifier;

  String name = '';

  String identifier = '';

  bool identifiered = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: this.name);
    _identifier = TextEditingController(text: this.identifier);
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(identifiered ? '已认证的个人信息' : '认证个人信息'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _name,
                decoration: InputDecoration(hintText: '请输入用户姓名'),
                keyboardType: TextInputType.text,
                enableInteractiveSelection: false,
                enabled: !identifiered,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (e) {
                  name = e;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _identifier,
                decoration: InputDecoration(hintText: '请输入身份证'),
                keyboardType: TextInputType.text,
                enableInteractiveSelection: false,
                enabled: !identifiered,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (e) {
                  identifier = e;
                },
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: identifiered
                    ? null
                    : () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        String alert = '';
                        if (name == null || name.isEmpty) {
                          alert = '请输入用户名';
                        } else if (identifier == null ||
                            !Global.isCardId(identifier)) {
                          alert = '请输入正确的身份证号码';
                        }

                        if (alert.isNotEmpty) {
                          alertDialog(context, content: alert);
                          return;
                        }

                        WebServices.fillIdentifier(name, identifier)
                            .then((value) {
                          print(value);
                          if (value.statusCode == 201) {
                            SManager.showMessage('信息认证成功');
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName(Routes.tab));
                          } else {
                            alertDialog(context, content: value.data.toString());
                          }
                        }).catchError((error) {
                          SManager.dioErrorHandle(context, error);
                        });
                      },
                child: Text('提交'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _request() {
    WebServices.identifier().then((value) {
      if (value.statusCode == 200) {
        this.name = value.data['name'] as String;
        this.identifier = value.data['number'] as String;
        identifiered = true;

        setState(() {
          _name.text = this.name;
          _identifier.text = this.identifier;
        });
      } else if (value.statusCode == 204) {}
    }).catchError((error) {
      SManager.dioErrorHandle(context, error);
    });
  }
}
