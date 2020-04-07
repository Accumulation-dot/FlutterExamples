import 'package:flutter/material.dart';

class AnimatedIconsWidget extends StatefulWidget {
  @override
  _AnimatedIconsWidgetState createState() => _AnimatedIconsWidgetState();
}

class _AnimatedIconsWidgetState extends State<AnimatedIconsWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final List<AnimatedIconData> icons = [
    AnimatedIcons.add_event,
    AnimatedIcons.arrow_menu,
    AnimatedIcons.close_menu,
    AnimatedIcons.ellipsis_search,
    AnimatedIcons.event_add,
    AnimatedIcons.home_menu,
    AnimatedIcons.list_view,
    AnimatedIcons.menu_arrow,
    AnimatedIcons.menu_close,
    AnimatedIcons.menu_home,
    AnimatedIcons.pause_play,
    AnimatedIcons.play_pause,
    AnimatedIcons.search_ellipsis,
    AnimatedIcons.view_list
  ];
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..drive(Tween(begin: 0.0, end: 1.0));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> container = [];
    for (var item in icons) {
      container.add(AnimatedIcon(
        icon: item,
        progress: _controller,
        size: 40.0,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Icons'),
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: _controller,
          ),
          onPressed: () {
            switch (_controller.status) {
              case AnimationStatus.dismissed:
                _controller.forward();
                break;
              case AnimationStatus.completed:
                _controller.reverse();
                break;
              default:
                break;
            }
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: container,
        ),
      ),
    );
  }
}
