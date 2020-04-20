// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellOrderList _$SellOrderListFromJson(Map<String, dynamic> json) {
  return SellOrderList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : SellOrder.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SellOrderListToJson(SellOrderList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

SellOrder _$SellOrderFromJson(Map<String, dynamic> json) {
  return SellOrder(
    json['user'] as String,
    json['created'] as String,
    json['sell'] == null
        ? null
        : SellItem.fromJson(json['sell'] as Map<String, dynamic>),
    json['status_desc'] as String,
    json['status'] as int,
    json['serial_no'] as String,
    json['detail'] as String,
  );
}

Map<String, dynamic> _$SellOrderToJson(SellOrder instance) => <String, dynamic>{
      'user': instance.user,
      'created': instance.created,
      'sell': instance.sell,
      'status_desc': instance.statusDesc,
      'status': instance.status,
      'serial_no': instance.serialNo,
      'detail': instance.detail,
    };
