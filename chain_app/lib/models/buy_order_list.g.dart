// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyOrderList _$BuyOrderListFromJson(Map<String, dynamic> json) {
  return BuyOrderList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : BuyOrder.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BuyOrderListToJson(BuyOrderList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };
