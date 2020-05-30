import 'package:chain_app/models/sell_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sell_order_list.g.dart';

@JsonSerializable()
class SellOrderList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<SellOrder> list;

  SellOrderList(
    this.count,
    this.next,
    this.list,
  );

  factory SellOrderList.fromJson(Map<String, dynamic> srcJson) =>
      _$SellOrderListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SellOrderListToJson(this);
}

@JsonSerializable()
class SellOrder extends Object {
  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'sell')
  SellItem sell;

  @JsonKey(name: 'status_desc')
  String statusDesc;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'serial_no')
  String serialNo;

  @JsonKey(name: 'detail')
  String detail;

  SellOrder(
    this.user,
    this.created,
    this.sell,
    this.statusDesc,
    this.status,
    this.serialNo,
    this.detail,
  );

  factory SellOrder.fromJson(Map<String, dynamic> srcJson) =>
      _$SellOrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SellOrderToJson(this);
}
