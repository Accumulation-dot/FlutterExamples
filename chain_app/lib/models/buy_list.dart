import 'package:chain_app/models/pay_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buy_list.g.dart';

@JsonSerializable()
class BuyList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<BuyItem> list;

  BuyList(
    this.count,
    this.next,
    this.list,
  );

  factory BuyList.fromJson(Map<String, dynamic> srcJson) =>
      _$BuyListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuyListToJson(this);
}

@JsonSerializable()
class BuyItem extends Object {

  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'status_desc')
  String statusDesc;

  @JsonKey(name: 'records')
  BuyOrder records;

  @JsonKey(name: 'number')
  double number;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'serial_no')
  String serialNo;

  @JsonKey(name: 'price')
  double price;

  BuyItem(this.user,this.created,this.statusDesc,this.records,this.number,this.status,this.serialNo,this.price,);

  factory BuyItem.fromJson(Map<String, dynamic> srcJson) => _$BuyItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuyItemToJson(this);

}

@JsonSerializable()
class Buy extends Object {
  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'status_desc')
  String statusDesc;

  @JsonKey(name: 'number')
  double number;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'serial_no')
  String serialNo;

  @JsonKey(name: 'price')
  double price;

  Buy(this.user,this.created,this.statusDesc,this.number,this.status,this.serialNo,this.price,);

  factory Buy.fromJson(Map<String, dynamic> srcJson) => _$BuyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuyToJson(this);
}


@JsonSerializable()
class BuyOrder extends Object {

  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'pays')
  List<Pay> pays;

  @JsonKey(name: 'status_desc')
  String statusDesc;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'serial_no')
  String serialNo;

  @JsonKey(name: 'detail')
  String detail;

  @JsonKey(name: 'buy')
  Buy buy;

  BuyOrder(this.user,this.pays,this.statusDesc,this.created,this.status,this.serialNo, this.detail, this.buy);

  factory BuyOrder.fromJson(Map<String, dynamic> srcJson) => _$BuyOrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuyOrderToJson(this);

}
