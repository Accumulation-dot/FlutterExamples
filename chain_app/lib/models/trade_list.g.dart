// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeList _$TradeListFromJson(Map<String, dynamic> json) {
  return TradeList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : TradeItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TradeListToJson(TradeList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

TradeItem _$TradeItemFromJson(Map<String, dynamic> json) {
  return TradeItem(
    json['id'] as int,
    json['type_desc'] as String,
    json['user'] == null
        ? null
        : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    json['status_desc'] as String,
    (json['number'] as num)?.toDouble(),
    json['type'] as int,
    json['status'] as int,
  );
}

Map<String, dynamic> _$TradeItemToJson(TradeItem instance) => <String, dynamic>{
      'id': instance.id,
      'type_desc': instance.typeDesc,
      'user': instance.user,
      'status_desc': instance.statusDesc,
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
    };
