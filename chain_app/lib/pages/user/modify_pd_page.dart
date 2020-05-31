import 'package:chain_app/pages/login/widgets/login_widget.dart';
import 'package:chain_app/style/w_style.dart';
import 'package:chain_app/tools/alert_dialog.dart';
import 'package:chain_app/tools/global.dart';
import 'package:chain_app/tools/s_manager.dart';
import 'package:chain_app/tools/services/login_services.dart';
import 'package:chain_app/tools/services/user_services.dart';
import 'package:chain_app/tools/tools.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ModifyEnum { forget, change }

class ModifyPDPage extends StatefulWidget {
  final modifyEnum;

  const ModifyPDPage({Key key, this.modifyEnum = ModifyEnum.forget})
      : super(key: key);

  @override
  _ModifyPDPageState createState() => _ModifyPDPageState();
}

class _ModifyPDPageState extends State<ModifyPDPage> {
  TextEditingController _identifier;

  TextEditingController _mobile;

  TextEditingController _password;

  TextEditingController _oldPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _identifier = TextEditingController();
    _mobile = TextEditingController();
    _password = TextEditingController();
    _oldPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.modifyEnum == ModifyEnum.change
              ? Text('更改密码')
              : Text('找回密码')),
      body: Column(
        children: widget.modifyEnum == ModifyEnum.forget
            ? forgetPassword(context)
            : changePassword(context),
      ),
    );
  }

  @override
  void dispose() {
    _mobile.dispose();
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  List<Widget> forgetPassword(BuildContext context) {
    return [
      Container(
        padding: WStyle.symmetric(v: 20, h: 20),
        child: LoginWidget.mobileWidget(_mobile, autoFocus: true),
      ),
      Container(
        padding: WStyle.symmetric(h: 20, v: 20),
        child: TextField(
            controller: _identifier,
            decoration: InputDecoration(hintText: '请输入身份证'),
            keyboardType: TextInputType.text,
            enableInteractiveSelection: false,
            inputFormatters: [
              LengthLimitingTextInputFormatter(18),
            ]),
      ),
      Container(
        padding: WStyle.symmetric(h: 20, v: 20),
        child: LoginWidget.passwordWidget(_password),
      ),
      Container(
        padding: WStyle.symmetric(h: 20, v: 20),
        alignment: Alignment.center,
        child: RaisedButton(
            child: Text('提交'),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              String mobile = _mobile.text;
              String identifier = _identifier.text;
              String password = _password.text;
              if (!Tools.mobileReg(mobile)) {
                alertDialog(context, content: '请输入正确的手机号码!');
                return;
              }
              if (!Global.isCardId(identifier)) {
                alertDialog(context, content: '请输入身份证号码!');
                return;
              }

              if (!Tools.passwordReg(password)) {
                alertDialog(context, content: '请输入密码格式（数字和字母组合8-16位）');
                return;
              }

              LoginServices.forgetPassword(
                      username: mobile,
                      identifier: identifier,
                      password: password)
                  .then((value) {
                if (value.statusCode == 202) {
                  Navigator.of(context).pop();
                  alertDialog(context, content: '密码已经重置，请用新密码登陆');
                } else {
                  SManager.showMessage(value.data);
                }
              }).catchError((error) {
                SManager.dioErrorHandle(context, error);
              });
            }),
      )
    ];
  }

  List<Widget> changePassword(BuildContext context) {
    return [
      Container(
        padding: WStyle.symmetric(h: 20, v: 20),
        child: LoginWidget.passwordWidget(_oldPassword, hintText: '请输入原密码'),
      ),
      Container(
        padding: WStyle.symmetric(h: 20, v: 20),
        child: LoginWidget.passwordWidget(_password, hintText: '请输入新密码'),
      ),
      Container(
        padding: WStyle.symmetric(h: 20, v: 20),
        alignment: Alignment.center,
        child: RaisedButton(
            child: Text('提交'),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              String op = _oldPassword.text;
              String np = _password.text;

              if (!Tools.passwordReg(np)) {
                alertDialog(context, content: '密码要求（数字和字母组合8-16位）');
                return;
              }

              UserServices.modifyPassword(op, np).then((value) {
                if (value.statusCode == 202) {
                  SManager.logout(context, message: '密码修改成功，请重新登陆');
                } else {
                  SManager.showMessage(value.data);
                }
              }).catchError((error) {
                SManager.dioErrorHandle(context, error);
              });
            }),
      )
    ];
  }
}
