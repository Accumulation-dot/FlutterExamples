// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_record_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MRecordList _$MRecordListFromJson(Map<String, dynamic> json) {
  return MRecordList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : MRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MRecordListToJson(MRecordList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

MRecord _$MRecordFromJson(Map<String, dynamic> json) {
  return MRecord(
    json['id'] as int,
    json['created'] as String,
    json['expired'] as String,
    json['machine'] as String,
    json['user'] as String,
    json['days'] as int,
    (json['number'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MRecordToJson(MRecord instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'expired': instance.expired,
      'machine': instance.machine,
      'user': instance.user,
      'days': instance.days,
      'number': instance.number,
    };
