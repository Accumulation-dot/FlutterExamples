// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_record_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskRecordList _$TaskRecordListFromJson(Map<String, dynamic> json) {
  return TaskRecordList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : TaskRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TaskRecordListToJson(TaskRecordList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

TaskRecord _$TaskRecordFromJson(Map<String, dynamic> json) {
  return TaskRecord(
    json['user'] as String,
    json['date'] as String,
    (json['earn'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TaskRecordToJson(TaskRecord instance) =>
    <String, dynamic>{
      'user': instance.user,
      'date': instance.date,
      'earn': instance.earn,
    };
