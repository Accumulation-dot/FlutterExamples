import 'package:flutter/material.dart';
import 'package:myapp/models/commodity.dart';

class CommodityDetailPage extends StatefulWidget {
  final Commodity commodity;

  const CommodityDetailPage({Key key, this.commodity}) : super(key: key);

  @override
  _CommodityDetailPageState createState() => _CommodityDetailPageState();
}

class _CommodityDetailPageState extends State<CommodityDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(widget.commodity.iconData),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.commodity.title),
      ),
    );
  }
}
