// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineList _$MachineListFromJson(Map<String, dynamic> json) {
  return MachineList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Machine.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MachineListToJson(MachineList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

Machine _$MachineFromJson(Map<String, dynamic> json) {
  return Machine(
    json['id'] as int,
    json['title'] as String,
    json['count'] as int,
    json['days'] as int,
    (json['number'] as num)?.toDouble(),
    json['append'] as int,
    (json['cost'] as num)?.toDouble(),
    json['s_no'] as String,
    json['max_count'] as int,
    json['given'] as bool,
  );
}

Map<String, dynamic> _$MachineToJson(Machine instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'count': instance.count,
      'days': instance.days,
      'number': instance.number,
      'append': instance.append,
      'cost': instance.cost,
      's_no': instance.sNo,
      'max_count': instance.maxCount,
      'given': instance.given,
    };
