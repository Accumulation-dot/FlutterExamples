import 'package:chain_app/pages/login/widgets/login_widget.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final LoginCallback callback;

  const Login({Key key, this.callback}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _username = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = const EdgeInsets.all(20);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: edgeInsets,
            child: LoginWidget.mobileWidget(_username),
          ),
          Container(
            padding: edgeInsets,
            child: LoginWidget.passwordWidget(_password),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                String mobile = _username.text;
                String password = _password.text;
                if (!Tools.mobileReg(mobile)) {
                  alertDialog(context, content: '请输入正确的手机号码!');
                  return;
                }
                if (!Tools.passwordReg(password)) {
                  alertDialog(context, content: '请输入密码!');
                  return;
                }
                widget.callback(mobile, password, '');
              },
              child: Text('提交'),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _password.dispose();
    _username.dispose();
    super.dispose();
  }
}
