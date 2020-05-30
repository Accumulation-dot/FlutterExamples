import 'package:flutter/material.dart';

class RouteAnimation extends PageRouteBuilder {
  final Widget widget;

  RouteAnimation(this.widget)
      : super(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, an1, an2) {
            return widget;
          },
          transitionsBuilder: (context, a1, a2, child) {
            return FadeTransition(
              opacity: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: a1,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        );
}
