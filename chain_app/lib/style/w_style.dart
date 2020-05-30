import 'package:flutter/material.dart';

class WStyle {
  static const green = const TextStyle(color: Colors.green);

  static const blue = const TextStyle(color: Colors.blue);

  static const black = const TextStyle(color: Colors.black);

  static const white = const TextStyle(color: Colors.white);

  static const confirmColor = Colors.orange;

  static final roundedBorder20 = WStyle.roundedBorder(circular: 20);

  static final borderRadius4 = WStyle.borderRadius();

  static const tipStyle = const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic);

  static const titleStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal);

  static BorderRadius borderRadius({double circular = 4}) {
    return BorderRadius.circular(circular);
  }

  static roundedBorder(
      {double circular = 0, BorderSide side = BorderSide.none}) {
    return RoundedRectangleBorder(
      side: side,
      borderRadius: WStyle.borderRadius(circular: 20),
    );
  }

  static TextSpan blueText(String content) {
    return TextSpan(text: content, style: blue);
  }

  static TextSpan greenText(String content) {
    return TextSpan(text: content, style: green);
  }

  static TextSpan textSpans(List<TextSpan> texts) {
    return TextSpan(children: texts);
  }

  static TextSpan textSpan(
      {String pre = '',
      TextStyle preStyle = blue,
      String content = '',
      TextStyle contentStyle = green}) {
    return TextSpan(text: pre, style: preStyle, children: [
      TextSpan(
        text: content,
        style: contentStyle,
      ),
    ]);
  }

  static EdgeInsets symmetric({double h = 0, double v = 0}) {
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  static EdgeInsets edgeInsetsOnly(
      {double l = 0, double t = 0, double r = 0, double b = 0}) {
    return EdgeInsets.only(left: l, top: t, bottom: b, right: r);
  }

  static inputBorder({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
        borderSide: BorderSide(
      color: borderColor,
    ));
  }
}
