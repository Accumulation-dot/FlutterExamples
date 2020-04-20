// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return Summary(
    json['id'] as int,
    json['identified'] as int,
    json['bank'] as int,
    json['ali'] as int,
    (json['count'] as num)?.toDouble(),
    (json['shop'] as num)?.toDouble(),
    json['phone'] as String,
    json['created'] as String,
    json['name'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'id': instance.id,
      'identified': instance.identified,
      'bank': instance.bank,
      'ali': instance.ali,
      'count': instance.count,
      'shop': instance.shop,
      'phone': instance.phone,
      'created': instance.created,
      'name': instance.name,
      'address': instance.address,
    };
