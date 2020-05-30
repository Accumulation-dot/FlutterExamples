// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rules _$RulesFromJson(Map<String, dynamic> json) {
  return Rules(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map(
            (e) => e == null ? null : Rule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RulesToJson(Rules instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

Rule _$RuleFromJson(Map<String, dynamic> json) {
  return Rule(
    json['name'] as String,
    (json['min_num'] as num)?.toDouble(),
    (json['tax'] as num)?.toDouble(),
    (json['shop'] as num)?.toDouble(),
    (json['advert'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
      'name': instance.name,
      'min_num': instance.minNum,
      'tax': instance.tax,
      'shop': instance.shop,
      'advert': instance.advert,
    };
