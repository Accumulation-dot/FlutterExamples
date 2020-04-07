import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
//        _more(); // 当滑到最底部时调用
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易记录'),
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('时间'),
                  subtitle: Container(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              print('去卖家');
                            },
                            child: Container(
                              child: Text(
                                '11241241241241241241',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              print('去买家');
                            },
                            child: Container(
                              child: Text(
                                '11241241241241241241',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Text('数量'),
                ),
              );
            },
            controller: _scrollController,
          ),
          onRefresh: _refresh),
    );
  }

  Future _refresh() async {
    final duration = Duration(seconds: 3);
    await Future.delayed(duration).then((value) {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
