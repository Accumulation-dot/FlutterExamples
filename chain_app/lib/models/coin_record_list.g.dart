// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_record_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinRecordList _$CoinRecordListFromJson(Map<String, dynamic> json) {
  return CoinRecordList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : CoinRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CoinRecordListToJson(CoinRecordList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

CoinRecord _$CoinRecordFromJson(Map<String, dynamic> json) {
  return CoinRecord(
    json['datetime'] as String,
    json['key'] as String,
    (json['point'] as num)?.toDouble(),
    (json['shop'] as num)?.toDouble(),
    json['desc'] as String,
  );
}

Map<String, dynamic> _$CoinRecordToJson(CoinRecord instance) =>
    <String, dynamic>{
      'datetime': instance.datetime,
      'key': instance.key,
      'point': instance.point,
      'shop': instance.shop,
      'desc': instance.desc,
    };
