import 'package:chain_app/pages/login/widgets/login_widget.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final LoginCallback callback;

  const Register({Key key, this.callback}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _username = TextEditingController();

  TextEditingController _password = TextEditingController();

  TextEditingController _inviter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = const EdgeInsets.all(20);

    return Container(
      child: Column(
        children: [
          Container(
            padding: edgeInsets,
            child: LoginWidget.mobileWidget(_username),
          ),
          Container(
            padding: edgeInsets,
            child: LoginWidget.passwordWidget(_password),
          ),
          Container(
            padding: edgeInsets,
            child: LoginWidget.inviterWidget(_inviter),
          ),
          Container(
            child: Center(
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
                    alertDialog(context, content: '密码规则为：8-16位 包含数字和字母');
                    return;
                  }
                  widget.callback(mobile, password, _inviter.text ?? '');
                },
                child: Text('提交'),
              ),
            ),
          ),
        ],
      ),
    );
//      Container(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Padding(
//            padding: edgeInsets,
//            child: LoginWidget.mobileWidget(_username),
//          ),
//          Padding(
//            padding: edgeInsets,
//            child: LoginWidget.passwordWidget(_password),
//          ),
//          Padding(
//            padding: edgeInsets,
//            child: LoginWidget.inviterWidget(_inviter),
//          ),
//          Center(
//            child: RaisedButton(
//              onPressed: () {
//                FocusScope.of(context).requestFocus(FocusNode());
//                String mobile = _username.text;
//                String password = _password.text;
//                if (!Tools.mobileReg(mobile)) {
//                  alertDialog(context, content: '请输入正确的手机号码!');
//                  return;
//                }
//
//                if (!Tools.passwordReg(password)) {
//                  alertDialog(context, content: '密码规则为：8-16位 数字和');
//                  return;
//                }
//                widget.callback(mobile, password, _inviter.text ?? '');
//              },
//              child: Text('提交'),
//            ),
//          ),
//        ],
//      ),
//    );
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _inviter.dispose();
    super.dispose();
  }
}
