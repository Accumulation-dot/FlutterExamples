// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyList _$BuyListFromJson(Map<String, dynamic> json) {
  return BuyList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : BuyItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BuyListToJson(BuyList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

BuyItem _$BuyItemFromJson(Map<String, dynamic> json) {
  return BuyItem(
    json['user'] as String,
    json['created'] as String,
    json['status_desc'] as String,
    json['records'] == null
        ? null
        : BuyOrder.fromJson(json['records'] as Map<String, dynamic>),
    (json['number'] as num)?.toDouble(),
    json['status'] as int,
    json['serial_no'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BuyItemToJson(BuyItem instance) => <String, dynamic>{
      'user': instance.user,
      'created': instance.created,
      'status_desc': instance.statusDesc,
      'records': instance.records,
      'number': instance.number,
      'status': instance.status,
      'serial_no': instance.serialNo,
      'price': instance.price,
    };

Buy _$BuyFromJson(Map<String, dynamic> json) {
  return Buy(
    json['user'] as String,
    json['created'] as String,
    json['status_desc'] as String,
    (json['number'] as num)?.toDouble(),
    json['status'] as int,
    json['serial_no'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BuyToJson(Buy instance) => <String, dynamic>{
      'user': instance.user,
      'created': instance.created,
      'status_desc': instance.statusDesc,
      'number': instance.number,
      'status': instance.status,
      'serial_no': instance.serialNo,
      'price': instance.price,
    };

BuyOrder _$BuyOrderFromJson(Map<String, dynamic> json) {
  return BuyOrder(
    json['user'] as String,
    (json['pays'] as List)
        ?.map((e) => e == null ? null : Pay.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status_desc'] as String,
    json['created'] as String,
    json['status'] as int,
    json['serial_no'] as String,
    json['detail'] as String,
    json['buy'] == null
        ? null
        : Buy.fromJson(json['buy'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BuyOrderToJson(BuyOrder instance) => <String, dynamic>{
      'user': instance.user,
      'pays': instance.pays,
      'status_desc': instance.statusDesc,
      'created': instance.created,
      'status': instance.status,
      'serial_no': instance.serialNo,
      'detail': instance.detail,
      'buy': instance.buy,
    };
