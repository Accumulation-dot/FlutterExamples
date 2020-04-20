import 'package:chain_app/models/pay_list.dart';
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

  SellItem(this.user,this.statusDesc,this.created,this.pays,this.number,this.status,this.serialNo,this.price,);

  factory SellItem.fromJson(Map<String, dynamic> srcJson) => _$SellItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SellItemToJson(this);

}

  
