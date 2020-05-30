import 'package:chain_app/models/pay_list.dart';
import 'package:chain_app/models/sell_order_list.dart';
import 'package:json_annotation/json_annotation.dart';
  
part 'sell_list.g.dart';


@JsonSerializable()
  class SellList extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<SellItem> list;

  SellList(this.count,this.next,this.list,);

  factory SellList.fromJson(Map<String, dynamic> srcJson) => _$SellListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SellListToJson(this);

}

//@JsonSerializable()
//class Sell extends Object {
//  @JsonKey(name: 'user')
//  String user;
//
//  @JsonKey(name: 'created')
//  String created;
//
//  @JsonKey(name: 'status_desc')
//  String statusDesc;
//
//  @JsonKey(name: 'status')
//  int status;
//
//  @JsonKey(name: 'serial_no')
//  String serialNo;
//
//  @JsonKey(name: 'detail')
//  String detail;
//
//  Sell(
//      this.user,
//      this.created,
//      this.statusDesc,
//      this.status,
//      this.serialNo,
//      this.detail,
//      );
//
//  factory Sell.fromJson(Map<String, dynamic> srcJson) =>
//      _$SellFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$SellToJson(this);
//}

  
@JsonSerializable()
  class SellItem extends Object {

  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'status_desc')
  String statusDesc;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'pays')
  List<Pay> pays;

  @JsonKey(name: 'number')
  double number;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'serial_no')
  String serialNo;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'detail')
  String detail;

  SellItem(this.user,this.statusDesc,this.created,this.pays,this.number,this.status,this.serialNo,this.price, this.detail);

  factory SellItem.fromJson(Map<String, dynamic> srcJson) => _$SellItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SellItemToJson(this);

}

  
