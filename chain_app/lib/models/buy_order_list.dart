import 'package:chain_app/models/buy_list.dart';
import 'package:chain_app/models/pay_list.dart';
import 'package:json_annotation/json_annotation.dart';
  
part 'buy_order_list.g.dart';


@JsonSerializable()
  class BuyOrderList extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<BuyOrder> list;

  BuyOrderList(this.count,this.next,this.list,);

  factory BuyOrderList.fromJson(Map<String, dynamic> srcJson) => _$BuyOrderListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuyOrderListToJson(this);

}



  
