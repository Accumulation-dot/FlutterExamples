// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellList _$SellListFromJson(Map<String, dynamic> json) {
  return SellList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : SellItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SellListToJson(SellList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

SellItem _$SellItemFromJson(Map<String, dynamic> json) {
  return SellItem(
    json['user'] as String,
    json['status_desc'] as String,
    json['created'] as String,
    (json['pays'] as List)
        ?.map((e) => e == null ? null : Pay.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['number'] as num)?.toDouble(),
    json['status'] as int,
    json['serial_no'] as String,
    (json['price'] as num)?.toDouble(),
    json['detail'] as String,
  );
}

Map<String, dynamic> _$SellItemToJson(SellItem instance) => <String, dynamic>{
      'user': instance.user,
      'status_desc': instance.statusDesc,
      'created': instance.created,
      'pays': instance.pays,
      'number': instance.number,
      'status': instance.status,
      'serial_no': instance.serialNo,
      'price': instance.price,
      'detail': instance.detail,
    };
