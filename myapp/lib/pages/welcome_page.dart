import 'package:flutter/material.dart';

/// 欢迎页
class WelcomePage extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.white,
    Colors.blue,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          onPageChanged: (index) {
            print(index);
          },
          controller: PageController(initialPage: 0, viewportFraction: 1.0),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            if (index == colors.length - 1) {
              return Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Container(
                    child: Card(
                      color: colors[index],
                    ),
                  ),
                  Center(
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: Colors.lightBlue, width: 1)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('进入APP'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Card(
                color: colors[index],
              );
            }
          }),
    );
  }
}
