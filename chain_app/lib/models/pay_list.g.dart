// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayList _$PayListFromJson(Map<String, dynamic> json) {
  return PayList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) => e == null ? null : Pay.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PayListToJson(PayList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

Pay _$PayFromJson(Map<String, dynamic> json) {
  return Pay(
    json['type_desc'] as String,
    json['type'] as String,
    json['name'] as String,
    json['number'] as String,
    json['user'] as String,
    json['use'] as bool,
  );
}

Map<String, dynamic> _$PayToJson(Pay instance) => <String, dynamic>{
      'type_desc': instance.typeDesc,
      'type': instance.type,
      'name': instance.name,
      'number': instance.number,
      'user': instance.user,
      'use': instance.use,
    };
